import type { Quote } from "../../../domain/quote.js";
import { moneyDto } from "./money-dto.js";

/** Serializes a Quote to its HTTP response shape (see spec § Contrato de la API). */
export const toQuoteResponse = (quote: Quote) => ({
  quoteId: quote.id,
  sourceAmount: moneyDto(quote.sourceAmount),
  fee: moneyDto(quote.fee),
  destAmount: moneyDto(quote.destAmount),
  rate: { value: quote.rate.value, source: quote.rate.source, asOf: quote.rate.asOf },
  expiresAt: new Date(quote.expiresAt).toISOString(),
});
