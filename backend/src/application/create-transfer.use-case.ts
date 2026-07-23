import type { Clock } from "../domain/ports/clock.js";
import type { IdGenerator } from "../domain/ports/id-generator.js";
import type { QuoteRepository } from "../domain/ports/quote-repository.js";
import type { QuoteSigner } from "../domain/ports/quote-signer.js";
import type { TransferRepository } from "../domain/ports/transfer-repository.js";
import { Transfer } from "../domain/transfer.js";
import { type AppError, conflictError, ErrorCode, notFoundError } from "../shared/errors.js";
import { err, ok, type Result } from "../shared/result.js";

export interface CreateTransferDeps {
  readonly quotes: QuoteRepository;
  readonly transfers: TransferRepository;
  readonly signer: QuoteSigner;
  readonly clock: Clock;
  readonly ids: IdGenerator;
}

export interface CreateTransferCommand {
  readonly quoteId: string;
  readonly idempotencyKey: string;
}

/** A created transfer plus whether this call created it (201) or replayed an existing one (200). */
export interface CreateTransferOutput {
  readonly transfer: Transfer;
  readonly replayed: boolean;
}

/**
 * Creates a transfer from a stored quote, safe to call twice. Retry-safety layers:
 *  1. Same idempotency key + same quote -> returns the existing transfer (replayed).
 *  2. Same idempotency key + different quote -> IDEMPOTENCY_KEY_REUSED.
 *  3. A quote already consumed by another transfer -> QUOTE_ALREADY_USED (single-use).
 * The client sends only quoteId; all money comes from the stored quote (never the request body),
 * and the quote's HMAC is verified before use.
 */
export class CreateTransferUseCase {
  constructor(private readonly deps: CreateTransferDeps) {}

  execute(command: CreateTransferCommand): Result<CreateTransferOutput, AppError> {
    const existingByKey = this.deps.transfers.findByIdempotencyKey(command.idempotencyKey);
    if (existingByKey !== null) {
      if (existingByKey.quoteId === command.quoteId) {
        return ok({ transfer: existingByKey, replayed: true });
      }
      return err(
        conflictError(
          ErrorCode.IDEMPOTENCY_KEY_REUSED,
          "Idempotency-Key was already used for a different quote",
        ),
      );
    }

    const quote = this.deps.quotes.findById(command.quoteId);
    if (quote === null) {
      return err(notFoundError(ErrorCode.QUOTE_NOT_FOUND, `Quote ${command.quoteId} not found`));
    }

    if (quote.isExpired(this.deps.clock.now())) {
      return err(conflictError(ErrorCode.QUOTE_EXPIRED, "Quote has expired; request a new one"));
    }

    if (!this.deps.signer.verify(quote.integrityPayload(), quote.signature)) {
      return err(conflictError(ErrorCode.QUOTE_TAMPERED, "Quote failed integrity verification"));
    }

    if (this.deps.transfers.findByQuoteId(command.quoteId) !== null) {
      return err(
        conflictError(ErrorCode.QUOTE_ALREADY_USED, "Quote was already used by another transfer"),
      );
    }

    const transfer = Transfer.fromQuote({
      id: this.deps.ids.next(),
      quote,
      idempotencyKey: command.idempotencyKey,
      createdAt: this.deps.clock.now(),
    });
    this.deps.transfers.save(transfer);
    return ok({ transfer, replayed: false });
  }
}
