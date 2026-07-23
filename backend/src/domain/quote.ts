import { Currency } from "./currency.js";
import type { Money } from "./money.js";
import type { Rate } from "./rate.js";

/**
 * A priced MXN -> USD quote, valid until `expiresAt`. The destination amount is derived once here
 * as (source - fee) * rate; all money is stored as `Money` (integer minor units).
 */
export class Quote {
  private constructor(
    readonly id: string,
    readonly sourceAmount: Money,
    readonly rate: Rate,
    readonly fee: Money,
    readonly destAmount: Money,
    readonly createdAt: number,
    readonly expiresAt: number,
  ) {}

  static create(params: {
    id: string;
    sourceAmount: Money;
    rate: Rate;
    fee: Money;
    createdAt: number;
    ttlMs: number;
  }): Quote {
    const net = params.sourceAmount.minus(params.fee);
    const destAmount = net.applyRate(params.rate, Currency.USD);
    return new Quote(
      params.id,
      params.sourceAmount,
      params.rate,
      params.fee,
      destAmount,
      params.createdAt,
      params.createdAt + params.ttlMs,
    );
  }

  isExpired(now: number): boolean {
    return now >= this.expiresAt;
  }
}
