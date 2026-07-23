import { describe, expect, it } from "vitest";
import { Currency } from "./currency.js";
import { Money, MoneyError } from "./money.js";
import { Rate } from "./rate.js";

describe("Money construction", () => {
  it("given an integer minor amount, when ofMinor, then holds it", () => {
    expect(Money.ofMinor(100050, Currency.MXN).minorUnits).toBe(100050);
  });

  // CA-14: money never comes from a float.
  it("given a non-integer minor amount, when ofMinor, then throws", () => {
    expect(() => Money.ofMinor(100.5, Currency.MXN)).toThrow(MoneyError);
  });

  it("given a major decimal string, when fromMajor, then parses exact minor units", () => {
    expect(Money.fromMajor("1000.50", Currency.MXN).minorUnits).toBe(100050);
    expect(Money.fromMajor("1000", Currency.MXN).minorUnits).toBe(100000);
    expect(Money.fromMajor("0.07", Currency.USD).minorUnits).toBe(7);
  });

  it("given more decimals than the currency supports, when fromMajor, then throws", () => {
    expect(() => Money.fromMajor("1.234", Currency.MXN)).toThrow(MoneyError);
  });

  it("given a non-numeric string, when fromMajor, then throws", () => {
    expect(() => Money.fromMajor("abc", Currency.MXN)).toThrow(MoneyError);
  });
});

describe("Money arithmetic", () => {
  it("given same currency, when plus/minus, then combines minor units", () => {
    const a = Money.fromMajor("1000", Currency.MXN);
    const fee = Money.fromMajor("20", Currency.MXN);
    expect(a.minus(fee).minorUnits).toBe(98000);
    expect(a.plus(fee).minorUnits).toBe(102000);
  });

  it("given different currencies, when plus, then throws", () => {
    const mxn = Money.fromMajor("10", Currency.MXN);
    const usd = Money.fromMajor("10", Currency.USD);
    expect(() => mxn.plus(usd)).toThrow(MoneyError);
  });

  it("given two amounts, when isGreaterThan, then compares minor units", () => {
    const amount = Money.fromMajor("5000.01", Currency.MXN);
    const threshold = Money.fromMajor("5000", Currency.MXN);
    expect(amount.isGreaterThan(threshold)).toBe(true);
    expect(threshold.isGreaterThan(amount)).toBe(false);
  });
});

describe("Money.applyRate", () => {
  // CA-1 / CA-15: (amount - fee) * rate, rounded half-up exactly once.
  it("given 980 MXN and rate 0.05739, when applyRate, then 5624 USD cents", () => {
    const net = Money.fromMajor("980", Currency.MXN);
    const rate = Rate.of("0.05739", "stub", "2026-07-22");
    expect(net.applyRate(rate, Currency.USD).minorUnits).toBe(5624);
  });

  it("given a .5 minor boundary, when applyRate, then rounds half-up deterministically", () => {
    // 1 centavo * rate 0.025 = 0.025 cents -> half-up at the cent boundary is exercised via a
    // constructed rate that lands exactly on .5: 2 centavos * 0.125 = 0.25 -> 0 (below half),
    // 2 centavos * 0.25 = 0.5 -> 1 (half-up).
    const twoCentavos = Money.ofMinor(2, Currency.MXN);
    expect(
      twoCentavos.applyRate(Rate.of("0.125", "stub", "2026-07-22"), Currency.USD).minorUnits,
    ).toBe(0);
    expect(
      twoCentavos.applyRate(Rate.of("0.25", "stub", "2026-07-22"), Currency.USD).minorUnits,
    ).toBe(1);
  });

  it("given a negative amount, when applyRate, then throws", () => {
    expect(() =>
      Money.ofMinor(-100, Currency.MXN).applyRate(
        Rate.of("0.05", "stub", "2026-07-22"),
        Currency.USD,
      ),
    ).toThrow(MoneyError);
  });
});

describe("Money.toMajor", () => {
  it("given minor units, when toMajor, then returns the decimal major value", () => {
    expect(Money.ofMinor(5624, Currency.USD).toMajor()).toBe(56.24);
  });
});
