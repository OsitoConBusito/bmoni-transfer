import { describe, expect, it } from "vitest";
import { Currency } from "../domain/currency.js";
import { FeePolicy } from "../domain/fee.js";
import { Money } from "../domain/money.js";
import type { RateProvider, RateUnavailable } from "../domain/ports/rate-provider.js";
import type { Rate } from "../domain/rate.js";
import { FakeClock } from "../infrastructure/clock/fake-clock.js";
import { HmacQuoteSigner } from "../infrastructure/crypto/hmac-quote-signer.js";
import { SequentialIdGenerator } from "../infrastructure/id/sequential-id-generator.js";
import { InMemoryQuoteRepository } from "../infrastructure/persistence/in-memory-quote-repository.js";
import { StubRateProvider } from "../infrastructure/rate/stub-rate-provider.js";
import { err, type Result } from "../shared/result.js";
import { type GetQuoteDeps, GetQuoteUseCase } from "./get-quote.use-case.js";

const mxn = (major: string) => Money.fromMajor(major, Currency.MXN);

const buildUseCase = (overrides: Partial<GetQuoteDeps> = {}) => {
  const quotes = new InMemoryQuoteRepository();
  const useCase = new GetQuoteUseCase({
    rateProvider: new StubRateProvider("0.05739", "2026-07-22"),
    feePolicy: FeePolicy.of({ flat: mxn("20"), threshold: mxn("5000"), percentBasisPoints: 100 }),
    clock: new FakeClock(1_000),
    quotes,
    ids: new SequentialIdGenerator("quote"),
    signer: new HmacQuoteSigner("test-secret"),
    minAmount: mxn("10"),
    maxAmount: mxn("100000"),
    quoteTtlMs: 60_000,
    ...overrides,
  });
  return { useCase, quotes };
};

class FailingRateProvider implements RateProvider {
  getRate(): Promise<Result<Rate, RateUnavailable>> {
    return Promise.resolve(err({ code: "RATE_UNAVAILABLE" }));
  }
}

describe("GetQuoteUseCase happy path", () => {
  // CA-1: dest = (amount - fee) * rate, half-up.
  it("given 1000 MXN, when execute, then prices and stores the quote", async () => {
    const { useCase, quotes } = buildUseCase();

    const result = await useCase.execute("1000");

    expect(result.ok).toBe(true);
    if (result.ok) {
      expect(result.value.sourceAmount.minorUnits).toBe(100000);
      expect(result.value.fee.minorUnits).toBe(2000); // flat 20 MXN
      expect(result.value.destAmount.minorUnits).toBe(5624); // 980 * 0.05739 -> $56.24
      expect(result.value.expiresAt).toBe(61_000); // createdAt 1000 + ttl 60000
      expect(quotes.findById(result.value.id)).not.toBeNull();
    }
  });

  // CA-2: tiered fee flows through the quote.
  it("given 10000 MXN, when execute, then fee is flat + 1%", async () => {
    const { useCase } = buildUseCase();
    const result = await useCase.execute("10000");
    expect(result.ok && result.value.fee.minorUnits).toBe(12000); // 120.00 MXN
  });
});

describe("GetQuoteUseCase validation", () => {
  const cases: Array<[string, string | undefined, string]> = [
    ["required", undefined, "AMOUNT_REQUIRED"],
    ["not numeric", "abc", "AMOUNT_NOT_NUMERIC"],
    ["zero", "0", "AMOUNT_NOT_POSITIVE"],
    ["negative", "-5", "AMOUNT_NOT_POSITIVE"],
    ["below min", "5", "AMOUNT_TOO_LOW"],
    ["above max", "150000", "AMOUNT_TOO_HIGH"],
    ["below fee", "15", "AMOUNT_BELOW_FEE"],
  ];

  for (const [name, input, expectedCode] of cases) {
    it(`given ${name}, when execute, then ${expectedCode}`, async () => {
      const { useCase } = buildUseCase();
      const result = await useCase.execute(input);
      expect(result.ok).toBe(false);
      if (!result.ok) {
        expect(result.error.code).toBe(expectedCode);
      }
    });
  }
});

describe("GetQuoteUseCase rate unavailable", () => {
  // CA-6: provider down -> RATE_UNAVAILABLE, never an invented rate.
  it("given the rate source fails, when execute, then RATE_UNAVAILABLE", async () => {
    const { useCase } = buildUseCase({ rateProvider: new FailingRateProvider() });
    const result = await useCase.execute("1000");
    expect(result.ok).toBe(false);
    if (!result.ok) {
      expect(result.error.code).toBe("RATE_UNAVAILABLE");
    }
  });
});
