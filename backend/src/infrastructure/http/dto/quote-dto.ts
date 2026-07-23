import type { Money } from "../../../domain/money.js";
import type { Quote } from "../../../domain/quote.js";

/** Money on the wire: integer minor units + currency, never a decimal. */
const moneyDto = (money: Money) => ({ minorUnits: money.minorUnits, currency: money.currency });

/** Serializes a Quote to its HTTP response shape (see spec § Contrato de la API). */
export const toQuoteResponse = (quote: Quote) => ({
  quoteId: quote.id,
  sourceAmount: moneyDto(quote.sourceAmount),
  fee: moneyDto(quote.fee),
  destAmount: moneyDto(quote.destAmount),
  rate: { value: quote.rate.value, source: quote.rate.source, asOf: quote.rate.asOf },
  expiresAt: new Date(quote.expiresAt).toISOString(),
});
