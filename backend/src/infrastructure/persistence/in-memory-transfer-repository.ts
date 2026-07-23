import type { TransferRepository } from "../../domain/ports/transfer-repository.js";
import type { Transfer } from "../../domain/transfer.js";

/** In-memory transfer store with idempotency-key and quote indexes for retry-safe lookups. */
export class InMemoryTransferRepository implements TransferRepository {
  private readonly byId = new Map<string, Transfer>();
  private readonly idByKey = new Map<string, string>();
  private readonly idByQuote = new Map<string, string>();

  save(transfer: Transfer): void {
    this.byId.set(transfer.id, transfer);
    this.idByKey.set(transfer.idempotencyKey, transfer.id);
    this.idByQuote.set(transfer.quoteId, transfer.id);
  }

  findById(id: string): Transfer | null {
    return this.byId.get(id) ?? null;
  }

  findByIdempotencyKey(key: string): Transfer | null {
    return this.resolve(this.idByKey.get(key));
  }

  findByQuoteId(quoteId: string): Transfer | null {
    return this.resolve(this.idByQuote.get(quoteId));
  }

  private resolve(id: string | undefined): Transfer | null {
    return id === undefined ? null : (this.byId.get(id) ?? null);
  }
}
