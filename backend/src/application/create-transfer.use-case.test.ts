import { beforeEach, describe, expect, it } from "vitest";
import { Currency } from "../domain/currency.js";
import { Money } from "../domain/money.js";
import type { QuoteSigner } from "../domain/ports/quote-signer.js";
import { Quote } from "../domain/quote.js";
import { Rate } from "../domain/rate.js";
import { FakeClock } from "../infrastructure/clock/fake-clock.js";
import { HmacQuoteSigner } from "../infrastructure/crypto/hmac-quote-signer.js";
import { SequentialIdGenerator } from "../infrastructure/id/sequential-id-generator.js";
import { InMemoryQuoteRepository } from "../infrastructure/persistence/in-memory-quote-repository.js";
import { InMemoryTransferRepository } from "../infrastructure/persistence/in-memory-transfer-repository.js";
import { CreateTransferUseCase } from "./create-transfer.use-case.js";

const mxn = (major: string) => Money.fromMajor(major, Currency.MXN);
const CREATED_AT = 1_000;
const TTL = 60_000;

const buildQuote = (id: string, signer: QuoteSigner): Quote =>
  Quote.create(
    {
      id,
      sourceAmount: mxn("1000"),
      rate: Rate.of("0.05739", "stub", "2026-07-22"),
      fee: mxn("20"),
      feeBreakdown: {
        fixed: mxn("20"),
        variable: mxn("0"),
        threshold: mxn("5000"),
        percentBasisPoints: 100,
      },
      createdAt: CREATED_AT,
      ttlMs: TTL,
    },
    signer,
  );

let signer: HmacQuoteSigner;
let quotes: InMemoryQuoteRepository;
let transfers: InMemoryTransferRepository;
let clock: FakeClock;
let useCase: CreateTransferUseCase;

beforeEach(() => {
  signer = new HmacQuoteSigner("test-secret");
  quotes = new InMemoryQuoteRepository();
  transfers = new InMemoryTransferRepository();
  clock = new FakeClock(CREATED_AT);
  useCase = new CreateTransferUseCase({
    quotes,
    transfers,
    signer,
    clock,
    ids: new SequentialIdGenerator("transfer"),
  });
  quotes.save(buildQuote("quote-1", signer));
});

describe("CreateTransferUseCase happy path", () => {
  // CA-7: creates a transfer with the quote snapshot.
  it("given a valid quote + key, when execute, then creates a COMPLETED transfer", () => {
    const result = useCase.execute({ quoteId: "quote-1", idempotencyKey: "key-1" });

    expect(result.ok).toBe(true);
    if (result.ok) {
      expect(result.value.replayed).toBe(false);
      expect(result.value.transfer.status).toBe("COMPLETED");
      expect(result.value.transfer.destAmount.minorUnits).toBe(5624);
      expect(result.value.transfer.fee.minorUnits).toBe(2000);
    }
  });
});

describe("CreateTransferUseCase idempotency (retry-safe)", () => {
  // CA-8: two identical calls -> one transfer, second is a replay.
  it("given two identical calls, when execute twice, then one transfer and the second is replayed", () => {
    const first = useCase.execute({ quoteId: "quote-1", idempotencyKey: "key-1" });
    const second = useCase.execute({ quoteId: "quote-1", idempotencyKey: "key-1" });

    expect(first.ok && second.ok).toBe(true);
    if (first.ok && second.ok) {
      expect(second.value.replayed).toBe(true);
      expect(second.value.transfer.id).toBe(first.value.transfer.id);
    }
  });

  // CA-11: same key, different quote -> reuse conflict.
  it("given the same key with a different quote, when execute, then IDEMPOTENCY_KEY_REUSED", () => {
    quotes.save(buildQuote("quote-2", signer));
    useCase.execute({ quoteId: "quote-1", idempotencyKey: "key-1" });

    const result = useCase.execute({ quoteId: "quote-2", idempotencyKey: "key-1" });

    expect(result.ok).toBe(false);
    if (!result.ok) expect(result.error.code).toBe("IDEMPOTENCY_KEY_REUSED");
  });

  // A quote is single-use: a different key on an already-used quote is a conflict.
  it("given a quote already used by another key, when execute, then QUOTE_ALREADY_USED", () => {
    useCase.execute({ quoteId: "quote-1", idempotencyKey: "key-1" });

    const result = useCase.execute({ quoteId: "quote-1", idempotencyKey: "key-2" });

    expect(result.ok).toBe(false);
    if (!result.ok) expect(result.error.code).toBe("QUOTE_ALREADY_USED");
  });
});

describe("CreateTransferUseCase failures", () => {
  // CA-13
  it("given an unknown quote, when execute, then QUOTE_NOT_FOUND", () => {
    const result = useCase.execute({ quoteId: "missing", idempotencyKey: "key-1" });
    expect(result.ok).toBe(false);
    if (!result.ok) expect(result.error.code).toBe("QUOTE_NOT_FOUND");
  });

  // CA-9
  it("given an expired quote, when execute, then QUOTE_EXPIRED", () => {
    clock.advance(TTL);
    const result = useCase.execute({ quoteId: "quote-1", idempotencyKey: "key-1" });
    expect(result.ok).toBe(false);
    if (!result.ok) expect(result.error.code).toBe("QUOTE_EXPIRED");
  });

  // CA-S2: a quote whose signature does not verify is rejected.
  it("given a quote signed with a different secret, when execute, then QUOTE_TAMPERED", () => {
    quotes.save(buildQuote("quote-forged", new HmacQuoteSigner("other-secret")));
    const result = useCase.execute({ quoteId: "quote-forged", idempotencyKey: "key-9" });
    expect(result.ok).toBe(false);
    if (!result.ok) expect(result.error.code).toBe("QUOTE_TAMPERED");
  });
});
