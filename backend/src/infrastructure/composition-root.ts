import { CreateTransferUseCase } from "../application/create-transfer.use-case.js";
import { GetQuoteUseCase } from "../application/get-quote.use-case.js";
import { Currency } from "../domain/currency.js";
import { BASIS_POINTS_SCALE, FeePolicy } from "../domain/fee.js";
import { Money } from "../domain/money.js";
import type { Config } from "../shared/config.js";
import { SystemClock } from "./clock/system-clock.js";
import { HmacQuoteSigner } from "./crypto/hmac-quote-signer.js";
import { UuidGenerator } from "./id/uuid-generator.js";
import { InMemoryQuoteRepository } from "./persistence/in-memory-quote-repository.js";
import { InMemoryTransferRepository } from "./persistence/in-memory-transfer-repository.js";
import { createRateProvider } from "./rate/create-rate-provider.js";

/** The wired use cases the HTTP layer depends on. */
export interface AppDependencies {
  readonly getQuote: GetQuoteUseCase;
  readonly createTransfer: CreateTransferUseCase;
}

/** Composition root: builds adapters from config and wires them into the use cases. */
export const composeDependencies = (config: Config): AppDependencies => {
  const clock = new SystemClock();
  const rateProvider = createRateProvider(config, clock);
  const quotes = new InMemoryQuoteRepository();
  const transfers = new InMemoryTransferRepository();
  const ids = new UuidGenerator();
  const signer = new HmacQuoteSigner(config.HMAC_SECRET);

  const feePolicy = FeePolicy.of({
    flat: Money.fromMajor(String(config.FEE_FLAT_MXN), Currency.MXN),
    threshold: Money.fromMajor(String(config.FEE_THRESHOLD_MXN), Currency.MXN),
    percentBasisPoints: Math.round(config.FEE_PERCENT * BASIS_POINTS_SCALE),
  });

  const getQuote = new GetQuoteUseCase({
    rateProvider,
    feePolicy,
    clock,
    quotes,
    ids,
    signer,
    minAmount: Money.fromMajor(String(config.MIN_AMOUNT_MXN), Currency.MXN),
    maxAmount: Money.fromMajor(String(config.MAX_AMOUNT_MXN), Currency.MXN),
    quoteTtlMs: config.QUOTE_TTL_MS,
  });

  const createTransfer = new CreateTransferUseCase({ quotes, transfers, signer, clock, ids });

  return { getQuote, createTransfer };
};
