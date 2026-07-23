import type { Quote } from "../quote.js";

/** Persistence port for quotes. In-memory today, swappable to a DB without touching the domain. */
export interface QuoteRepository {
  save(quote: Quote): void;
  findById(id: string): Quote | null;
}
