import { Currency } from "./currency.js";
import type { Money } from "./money.js";
import type { QuoteSigner } from "./ports/quote-signer.js";
import type { Rate } from "./rate.js";

/**
 * A priced MXN -> USD quote, valid until `expiresAt`. The destination amount is derived once here
 * as (source - fee) * rate; all money is stored as `Money` (integer minor units). Carries an HMAC
 * `signature` over its integrity payload, set at creation and re-checked when a transfer confirms.
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
    readonly signature: string,
  ) {}

  static create(
    params: {
      id: string;
      sourceAmount: Money;
      rate: Rate;
      fee: Money;
      createdAt: number;
      ttlMs: number;
    },
    signer: QuoteSigner,
  ): Quote {
    const net = params.sourceAmount.minus(params.fee);
    const destAmount = net.applyRate(params.rate, Currency.USD);
    const expiresAt = params.createdAt + params.ttlMs;
    const payload = integrityPayload({
      id: params.id,
      sourceAmount: params.sourceAmount,
      fee: params.fee,
      destAmount,
      rate: params.rate,
      expiresAt,
    });
    return new Quote(
      params.id,
      params.sourceAmount,
      params.rate,
      params.fee,
      destAmount,
      params.createdAt,
      expiresAt,
      signer.sign(payload),
    );
  }

  isExpired(now: number): boolean {
    return now >= this.expiresAt;
  }

  /** Canonical string signed/verified for integrity. Order and fields are fixed. */
  integrityPayload(): string {
    return integrityPayload({
      id: this.id,
      sourceAmount: this.sourceAmount,
      fee: this.fee,
      destAmount: this.destAmount,
      rate: this.rate,
      expiresAt: this.expiresAt,
    });
  }
}

const integrityPayload = (q: {
  id: string;
  sourceAmount: Money;
  fee: Money;
  destAmount: Money;
  rate: Rate;
  expiresAt: number;
}): string =>
  [
    q.id,
    `${q.sourceAmount.minorUnits}:${q.sourceAmount.currency}`,
    `${q.fee.minorUnits}:${q.fee.currency}`,
    `${q.destAmount.minorUnits}:${q.destAmount.currency}`,
    q.rate.value,
    q.expiresAt,
  ].join("|");
