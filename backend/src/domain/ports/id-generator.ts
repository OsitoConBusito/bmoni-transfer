/** Port for unique id generation. Real impl uses crypto UUIDs; tests use a deterministic sequence. */
export interface IdGenerator {
  next(): string;
}
