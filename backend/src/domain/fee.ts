import type { Money } from "./money.js";

/** 1% expressed as basis points is 100 / 10_000. Percent config is converted to this integer base. */
export const BASIS_POINTS_SCALE = 10_000;

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
    if (!source.isGreaterThan(this.threshold)) {
      return this.flat;
    }
    return this.flat.plus(source.fraction(this.percentBasisPoints, BASIS_POINTS_SCALE));
  }
}
