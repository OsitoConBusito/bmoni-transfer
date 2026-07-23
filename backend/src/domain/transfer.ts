import type { Money } from "./money.js";
import type { Quote } from "./quote.js";
import type { Rate } from "./rate.js";
import { TransferStatus } from "./transfer-status.js";

/**
 * A recorded MXN -> USD transfer. Money fields are a snapshot copied from the quote at creation, so
 * the record is immutable and independent of later quote/rate changes. No real payment in this
 * slice, so it is created already COMPLETED.
 */
export class Transfer {
  private constructor(
    readonly id: string,
    readonly quoteId: string,
    readonly sourceAmount: Money,
    readonly destAmount: Money,
    readonly fee: Money,
    readonly rate: Rate,
    readonly status: TransferStatus,
    readonly idempotencyKey: string,
    readonly createdAt: number,
  ) {}

  static fromQuote(params: {
    id: string;
    quote: Quote;
    idempotencyKey: string;
    createdAt: number;
  }): Transfer {
    return new Transfer(
      params.id,
      params.quote.id,
      params.quote.sourceAmount,
      params.quote.destAmount,
      params.quote.fee,
      params.quote.rate,
      TransferStatus.COMPLETED,
      params.idempotencyKey,
      params.createdAt,
    );
  }
}
