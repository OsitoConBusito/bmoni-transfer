import { Money } from "./money.js";

/** 1% expressed as basis points is 100 / 10_000. Percent config is converted to this integer base. */
export const BASIS_POINTS_SCALE = 10_000;

/**
 * How a fee was composed, for display. `fixed` is the flat part; `variable` is the percent part
 * (zero below the threshold). `threshold`/`percentBasisPoints` describe the rule that produced it,
 * so the client can explain the fee without hardcoding the policy.
 */
export interface FeeBreakdown {
  readonly fixed: Money;
  readonly variable: Money;
  readonly threshold: Money;
  readonly percentBasisPoints: number;
}

/**
 * Tiered transfer fee: a flat fee below the threshold, and flat + percent of the amount above it.
 * The percent is applied to the FULL source amount (not only the excess), rounded half-up.
 * All amounts are MXN and share a currency, so `Money` arithmetic enforces consistency.
 */
export class FeePolicy {
  private constructor(
    private readonly flat: Money,
    private readonly threshold: Money,
    private readonly percentBasisPoints: number,
  ) {}

  static of(params: { flat: Money; threshold: Money; percentBasisPoints: number }): FeePolicy {
    return new FeePolicy(params.flat, params.threshold, params.percentBasisPoints);
  }

  computeFor(source: Money): Money {
    const { fixed, variable } = this.breakdownFor(source);
    return fixed.plus(variable);
  }

  /** The fee split into fixed + variable, with the rule that defined it. */
  breakdownFor(source: Money): FeeBreakdown {
    const overThreshold = source.isGreaterThan(this.threshold);
    const variable = overThreshold
      ? source.fraction(this.percentBasisPoints, BASIS_POINTS_SCALE)
      : Money.ofMinor(0, this.flat.currency);
    return {
      fixed: this.flat,
      variable,
      threshold: this.threshold,
      percentBasisPoints: this.percentBasisPoints,
    };
  }
}
