import { CURRENCY_EXPONENT, type Currency, minorUnitScale } from "./currency.js";
import type { Rate } from "./rate.js";

/** Raised on invalid money construction/operations. Programming error, not an expected domain path. */
export class MoneyError extends Error {}

/**
 * Money as an integer amount of minor units (centavos / cents) plus a currency.
 * Never a float — the whole point of the type is to keep money off IEEE-754.
 * Arithmetic that produces fractions (applyRate) keeps full precision and rounds
 * exactly once, half-up, at the boundary.
 */
export class Money {
  private constructor(
    readonly minorUnits: number,
    readonly currency: Currency,
  ) {}

  /** Build from an already-integer minor-unit amount. Rejects non-integers (a caught float bug). */
  static ofMinor(minorUnits: number, currency: Currency): Money {
    if (!Number.isInteger(minorUnits)) {
      throw new MoneyError(`minorUnits must be an integer, got ${minorUnits}`);
    }
    return new Money(minorUnits, currency);
  }

  /**
   * Build from a major-unit decimal STRING (e.g. "1000.50"), parsed exactly without
   * touching floating point. Rejects values with more decimals than the currency supports.
   */
  static fromMajor(major: string, currency: Currency): Money {
    const trimmed = major.trim();
    if (!/^-?\d+(\.\d+)?$/.test(trimmed)) {
      throw new MoneyError(`"${major}" is not a valid decimal amount`);
    }
    const negative = trimmed.startsWith("-");
    const [intPart, fracPart = ""] = trimmed.replace("-", "").split(".");
    const exponent = CURRENCY_EXPONENT[currency];
    if (fracPart.length > exponent) {
      throw new MoneyError(`"${major}" has more than ${exponent} decimals for ${currency}`);
    }
    const scale = minorUnitScale(currency);
    const minor = Number(intPart) * scale + Number(fracPart.padEnd(exponent, "0") || "0");
    return Money.ofMinor(negative ? -minor : minor, currency);
  }

  /** Like fromMajor but returns null instead of throwing, for validation paths (errors as values). */
  static tryFromMajor(major: string, currency: Currency): Money | null {
    try {
      return Money.fromMajor(major, currency);
    } catch {
      return null;
    }
  }

  /** Major-unit numeric view — for display/formatting only, never for further money math. */
  toMajor(): number {
    return this.minorUnits / minorUnitScale(this.currency);
  }

  plus(other: Money): Money {
    this.assertSameCurrency(other);
    return new Money(this.minorUnits + other.minorUnits, this.currency);
  }

  minus(other: Money): Money {
    this.assertSameCurrency(other);
    return new Money(this.minorUnits - other.minorUnits, this.currency);
  }

  isGreaterThan(other: Money): boolean {
    this.assertSameCurrency(other);
    return this.minorUnits > other.minorUnits;
  }

  /**
   * Convert to `target` by applying an FX rate. Both currencies share exponent 2 in this
   * slice, so target minor units = round_half_up(sourceMinor * rate). The multiplication
   * uses the rate's scaled integer and BigInt, so it is exact; rounding happens once here.
   */
  applyRate(rate: Rate, target: Currency): Money {
    if (this.minorUnits < 0) {
      throw new MoneyError("applyRate is only defined for non-negative amounts");
    }
    if (CURRENCY_EXPONENT[target] !== CURRENCY_EXPONENT[this.currency]) {
      throw new MoneyError(
        `applyRate requires equal minor-unit exponents (${this.currency}->${target})`,
      );
    }
    // Equal exponents, so targetMinor = round_half_up(sourceMinor * rate), exact via BigInt.
    const product = BigInt(this.minorUnits) * rate.scaledValue;
    const targetMinor = halfUpDivide(product, rate.scale);
    return Money.ofMinor(Number(targetMinor), target);
  }

  /**
   * This amount times an integer fraction numerator/denominator, rounded half-up, same
   * currency. Exact via BigInt — used e.g. for a percentage as basis points (1% = 100/10000).
   */
  fraction(numerator: number, denominator: number): Money {
    if (!Number.isInteger(numerator) || !Number.isInteger(denominator) || denominator <= 0) {
      throw new MoneyError(`fraction requires integer numerator and positive denominator`);
    }
    if (this.minorUnits < 0) {
      throw new MoneyError("fraction is only defined for non-negative amounts");
    }
    const product = BigInt(this.minorUnits) * BigInt(numerator);
    return Money.ofMinor(Number(halfUpDivide(product, BigInt(denominator))), this.currency);
  }

  private assertSameCurrency(other: Money): void {
    if (other.currency !== this.currency) {
      throw new MoneyError(`Currency mismatch: ${this.currency} vs ${other.currency}`);
    }
  }
}

/** Integer half-up division for non-negative numerators: floor((n + d/2) / d). */
const halfUpDivide = (numerator: bigint, divisor: bigint): bigint =>
  (numerator * 2n + divisor) / (divisor * 2n);
