import { describe, expect, it } from "vitest";
import { Rate, RateError } from "./rate.js";

describe("Rate", () => {
  it("given a decimal string, when of, then stores it as an exact scaled integer", () => {
    const rate = Rate.of("0.05739", "frankfurter", "2026-07-22");
    expect(rate.scaledValue).toBe(5739n);
    expect(rate.scale).toBe(100000n);
    expect(rate.value).toBe("0.05739");
    expect(rate.source).toBe("frankfurter");
  });

  it("given an integer string, when of, then scale is 1", () => {
    const rate = Rate.of("18", "stub", "2026-07-22");
    expect(rate.scaledValue).toBe(18n);
    expect(rate.scale).toBe(1n);
  });

  it("given a non-positive or non-numeric value, when of, then throws", () => {
    expect(() => Rate.of("0", "stub", "2026-07-22")).toThrow(RateError);
    expect(() => Rate.of("-1", "stub", "2026-07-22")).toThrow(RateError);
    expect(() => Rate.of("abc", "stub", "2026-07-22")).toThrow(RateError);
  });
});
