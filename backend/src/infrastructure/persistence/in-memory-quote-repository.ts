import type { QuoteRepository } from "../../domain/ports/quote-repository.js";
import type { Quote } from "../../domain/quote.js";

/** In-memory quote store. No DB in this slice; behind the QuoteRepository port. */
export class InMemoryQuoteRepository implements QuoteRepository {
  private readonly byId = new Map<string, Quote>();

  save(quote: Quote): void {
    this.byId.set(quote.id, quote);
  }

  findById(id: string): Quote | null {
    return this.byId.get(id) ?? null;
  }
}
