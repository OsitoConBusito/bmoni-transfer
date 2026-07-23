import { GetQuoteUseCase } from "../application/get-quote.use-case.js";
import { Currency } from "../domain/currency.js";
import { BASIS_POINTS_SCALE, FeePolicy } from "../domain/fee.js";
import { Money } from "../domain/money.js";
import type { Config } from "../shared/config.js";
import { SystemClock } from "./clock/system-clock.js";
import { UuidGenerator } from "./id/uuid-generator.js";
import { InMemoryQuoteRepository } from "./persistence/in-memory-quote-repository.js";
import { createRateProvider } from "./rate/create-rate-provider.js";

/** The wired use cases the HTTP layer depends on. */
export interface AppDependencies {
  readonly getQuote: GetQuoteUseCase;
}

/** Composition root: builds adapters from config and wires them into the use cases. */
export const composeDependencies = (config: Config): AppDependencies => {
  const clock = new SystemClock();
  const rateProvider = createRateProvider(config, clock);
  const quotes = new InMemoryQuoteRepository();
  const ids = new UuidGenerator();

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
    minAmount: Money.fromMajor(String(config.MIN_AMOUNT_MXN), Currency.MXN),
    maxAmount: Money.fromMajor(String(config.MAX_AMOUNT_MXN), Currency.MXN),
    quoteTtlMs: config.QUOTE_TTL_MS,
  });

  return { getQuote };
};
