import type { Transfer } from "../transfer.js";

/**
 * Persistence port for transfers. The two lookup methods back the retry-safety guarantee:
 * by idempotency key (same key -> same transfer) and by quote (a quote is single-use).
 */
export interface TransferRepository {
  save(transfer: Transfer): void;
  findById(id: string): Transfer | null;
  findByIdempotencyKey(key: string): Transfer | null;
  findByQuoteId(quoteId: string): Transfer | null;
}
