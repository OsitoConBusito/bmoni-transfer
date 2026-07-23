import { describe, expect, it } from "vitest";
import { Currency } from "./currency.js";
import { FeePolicy } from "./fee.js";
import { Money } from "./money.js";

const policy = FeePolicy.of({
  flat: Money.fromMajor("20", Currency.MXN),
  threshold: Money.fromMajor("5000", Currency.MXN),
  percentBasisPoints: 100, // 1%
});

const feeMajorFor = (amount: string): number =>
  policy.computeFor(Money.fromMajor(amount, Currency.MXN)).toMajor();

describe("FeePolicy (flat 20, threshold 5000, +1%)", () => {
  // CA-2: examples from the spec.
  it("given an amount at or below the threshold, when computeFor, then flat fee only", () => {
    expect(feeMajorFor("500")).toBe(20);
    expect(feeMajorFor("5000")).toBe(20); // exactly at threshold is not "above"
  });

  it("given an amount above the threshold, when computeFor, then flat + 1% of the full amount", () => {
    expect(feeMajorFor("10000")).toBe(120); // 20 + 100
    expect(feeMajorFor("50000")).toBe(520); // 20 + 500
  });

  it("given the percent applies to the full amount, when just above threshold, then rounds half-up", () => {
    // 5000.01 MXN -> 1% = 50.0001 -> half-up to 50.00 -> fee 70.00
    expect(feeMajorFor("5000.01")).toBe(70);
  });
});
