import type { Clock } from "../../domain/ports/clock.js";
import type { RateProvider } from "../../domain/ports/rate-provider.js";
import type { Config } from "../../shared/config.js";
import { CachedRateProvider } from "./cached-rate-provider.js";
import { FrankfurterRateProvider } from "./frankfurter-rate-provider.js";
import { StubRateProvider } from "./stub-rate-provider.js";

/** Composition root for the rate source: picks the provider by config and wraps it in a TTL cache. */
export const createRateProvider = (config: Config, clock: Clock): RateProvider => {
  const source: RateProvider =
    config.RATE_PROVIDER === "stub" ? new StubRateProvider() : new FrankfurterRateProvider();
  return new CachedRateProvider(source, clock, config.RATE_CACHE_TTL_MS);
};
