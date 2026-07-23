import { Currency } from "../domain/currency.js";
import type { FeePolicy } from "../domain/fee.js";
import { Money } from "../domain/money.js";
import type { Clock } from "../domain/ports/clock.js";
import type { IdGenerator } from "../domain/ports/id-generator.js";
import type { QuoteRepository } from "../domain/ports/quote-repository.js";
import type { QuoteSigner } from "../domain/ports/quote-signer.js";
import type { RateProvider } from "../domain/ports/rate-provider.js";
import { Quote } from "../domain/quote.js";
import { type AppError, ErrorCode, unavailableError, validationError } from "../shared/errors.js";
import { err, ok, type Result } from "../shared/result.js";

export interface GetQuoteDeps {
  readonly rateProvider: RateProvider;
  readonly feePolicy: FeePolicy;
  readonly clock: Clock;
  readonly quotes: QuoteRepository;
  readonly ids: IdGenerator;
  readonly signer: QuoteSigner;
  readonly minAmount: Money;
  readonly maxAmount: Money;
  readonly quoteTtlMs: number;
}

/** Validates the MXN amount, prices it against the current rate + fee, stores and returns a Quote. */
export class GetQuoteUseCase {
  constructor(private readonly deps: GetQuoteDeps) {}

  async execute(rawAmount: string | undefined): Promise<Result<Quote, AppError>> {
    const amount = this.validateAmount(rawAmount);
    if (!amount.ok) {
      return amount;
    }

    const fee = this.deps.feePolicy.computeFor(amount.value);
    if (!amount.value.isGreaterThan(fee)) {
      return err(
        validationError(
          ErrorCode.AMOUNT_BELOW_FEE,
          `Amount must be greater than the fee (${fee.toMajor()} MXN)`,
          "amount",
        ),
      );
    }

    const rate = await this.deps.rateProvider.getRate();
    if (!rate.ok) {
      return err(
        unavailableError(ErrorCode.RATE_UNAVAILABLE, "Exchange rate is temporarily unavailable"),
      );
    }

    const createdAt = this.deps.clock.now();
    const quote = Quote.create(
      {
        id: this.deps.ids.next(),
        sourceAmount: amount.value,
        rate: rate.value,
        fee,
        createdAt,
        ttlMs: this.deps.quoteTtlMs,
      },
      this.deps.signer,
    );
    this.deps.quotes.save(quote);
    return ok(quote);
  }

  private validateAmount(rawAmount: string | undefined): Result<Money, AppError> {
    if (rawAmount === undefined || rawAmount.trim() === "") {
      return err(validationError(ErrorCode.AMOUNT_REQUIRED, "Amount is required", "amount"));
    }
    const amount = Money.tryFromMajor(rawAmount, Currency.MXN);
    if (amount === null) {
      return err(
        validationError(
          ErrorCode.AMOUNT_NOT_NUMERIC,
          "Amount must be a valid MXN number",
          "amount",
        ),
      );
    }
    if (!amount.isPositive()) {
      return err(
        validationError(ErrorCode.AMOUNT_NOT_POSITIVE, "Amount must be positive", "amount"),
      );
    }
    if (this.deps.minAmount.isGreaterThan(amount)) {
      return err(
        validationError(
          ErrorCode.AMOUNT_TOO_LOW,
          `Amount is below the minimum of ${this.deps.minAmount.toMajor()} MXN`,
          "amount",
        ),
      );
    }
    if (amount.isGreaterThan(this.deps.maxAmount)) {
      return err(
        validationError(
          ErrorCode.AMOUNT_TOO_HIGH,
          `Amount exceeds the maximum of ${this.deps.maxAmount.toMajor()} MXN`,
          "amount",
        ),
      );
    }
    return ok(amount);
  }
}
