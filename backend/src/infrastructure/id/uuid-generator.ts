import { randomUUID } from "node:crypto";
import type { IdGenerator } from "../../domain/ports/id-generator.js";

/** Production id generator backed by crypto UUIDs. */
export class UuidGenerator implements IdGenerator {
  next(): string {
    return randomUUID();
  }
}
