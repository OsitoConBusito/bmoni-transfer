import { describe, expect, it, vi } from "vitest";
import type { RateProvider, RateUnavailable } from "../../domain/ports/rate-provider.js";
import { Rate } from "../../domain/rate.js";
import { err, ok, type Result } from "../../shared/result.js";
import { FakeClock } from "../clock/fake-clock.js";
import { CachedRateProvider } from "./cached-rate-provider.js";
import { FrankfurterRateProvider } from "./frankfurter-rate-provider.js";
import { StubRateProvider } from "./stub-rate-provider.js";

const jsonResponse = (body: unknown, ok = true): Response =>
  ({ ok, json: () => Promise.resolve(body) }) as Response;

describe("StubRateProvider", () => {
  it("given a stub, when getRate, then returns the fixed deterministic rate", async () => {
    const result = await new StubRateProvider("0.05739", "2026-07-22").getRate();
    expect(result.ok).toBe(true);
    if (result.ok) {
      expect(result.value.value).toBe("0.05739");
      expect(result.value.source).toBe("stub");
    }
  });
});

describe("FrankfurterRateProvider", () => {
  it("given a valid payload, when getRate, then parses the USD rate", async () => {
    const fetchFn = vi
      .fn()
      .mockResolvedValue(jsonResponse({ date: "2026-07-22", rates: { USD: 0.05739 } }));
    const result = await new FrankfurterRateProvider(fetchFn as unknown as typeof fetch).getRate();
    expect(result.ok).toBe(true);
    if (result.ok) {
      expect(result.value.value).toBe("0.05739");
      expect(result.value.asOf).toBe("2026-07-22");
    }
  });

  it("given a non-ok response, when getRate, then RATE_UNAVAILABLE", async () => {
    const fetchFn = vi.fn().mockResolvedValue(jsonResponse({}, false));
    const result = await new FrankfurterRateProvider(fetchFn as unknown as typeof fetch).getRate();
    expect(result.ok).toBe(false);
  });

  it("given a network error, when getRate, then RATE_UNAVAILABLE (no throw)", async () => {
    const fetchFn = vi.fn().mockRejectedValue(new Error("ECONNREFUSED"));
    const result = await new FrankfurterRateProvider(fetchFn as unknown as typeof fetch).getRate();
    expect(result.ok).toBe(false);
  });
});

/** Counts delegate calls and can be flipped to fail. */
class CountingProvider implements RateProvider {
  calls = 0;
  constructor(private mode: "ok" | "fail" = "ok") {}
  setMode(mode: "ok" | "fail"): void {
    this.mode = mode;
  }
  getRate(): Promise<Result<Rate, RateUnavailable>> {
    this.calls += 1;
    return Promise.resolve(
      this.mode === "ok"
        ? ok(Rate.of("0.05739", "stub", "2026-07-22"))
        : err({ code: "RATE_UNAVAILABLE" }),
    );
  }
}

describe("CachedRateProvider", () => {
  it("given a cached rate within TTL, when getRate, then serves cache without re-fetching", async () => {
    const delegate = new CountingProvider();
    const clock = new FakeClock(1_000);
    const cached = new CachedRateProvider(delegate, clock, 60_000);

    await cached.getRate();
    clock.advance(59_000);
    await cached.getRate();

    expect(delegate.calls).toBe(1);
  });

  it("given the TTL elapsed, when getRate, then re-fetches from the delegate", async () => {
    const delegate = new CountingProvider();
    const clock = new FakeClock(1_000);
    const cached = new CachedRateProvider(delegate, clock, 60_000);

    await cached.getRate();
    clock.advance(60_000);
    await cached.getRate();

    expect(delegate.calls).toBe(2);
  });

  it("given the delegate fails after TTL, when getRate, then the error propagates (no stale rate)", async () => {
    const delegate = new CountingProvider("ok");
    const clock = new FakeClock(1_000);
    const cached = new CachedRateProvider(delegate, clock, 60_000);

    await cached.getRate();
    clock.advance(60_000);
    delegate.setMode("fail");
    const result = await cached.getRate();

    expect(result.ok).toBe(false);
  });
});
