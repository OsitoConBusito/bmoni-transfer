import type { Transfer } from "../../../domain/transfer.js";
import { moneyDto } from "./money-dto.js";

/** Serializes a Transfer to its HTTP response shape (see spec § Contrato de la API). */
export const toTransferResponse = (transfer: Transfer) => ({
  transferId: transfer.id,
  status: transfer.status,
  quoteId: transfer.quoteId,
  sourceAmount: moneyDto(transfer.sourceAmount),
  destAmount: moneyDto(transfer.destAmount),
  fee: moneyDto(transfer.fee),
  rate: { value: transfer.rate.value, source: transfer.rate.source, asOf: transfer.rate.asOf },
  createdAt: new Date(transfer.createdAt).toISOString(),
});
