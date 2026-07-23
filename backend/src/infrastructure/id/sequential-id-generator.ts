import type { IdGenerator } from "../../domain/ports/id-generator.js";

/** Deterministic id generator for tests: quote-1, quote-2, ... */
export class SequentialIdGenerator implements IdGenerator {
  private counter = 0;

  constructor(private readonly prefix = "id") {}

  next(): string {
    this.counter += 1;
    return `${this.prefix}-${this.counter}`;
  }
}
