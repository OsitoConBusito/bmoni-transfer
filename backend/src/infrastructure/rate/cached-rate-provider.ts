import type { Clock } from "../../domain/ports/clock.js";
import type { RateProvider, RateUnavailable } from "../../domain/ports/rate-provider.js";
import type { Rate } from "../../domain/rate.js";
import { ok, type Result } from "../../shared/result.js";

/**
 * Wraps a RateProvider with an in-memory TTL cache so a quote does not trigger a network call per
 * request. A fetch failure is NOT masked by a stale cache: once the TTL passes, the delegate's
 * error propagates (so the edge can answer 503 rather than serve an outdated rate).
 */
export class CachedRateProvider implements RateProvider {
  private cached: { rate: Rate; at: number } | null = null;

  constructor(
    private readonly delegate: RateProvider,
    private readonly clock: Clock,
    private readonly ttlMs: number,
  ) {}

  async getRate(): Promise<Result<Rate, RateUnavailable>> {
    const now = this.clock.now();
    if (this.cached && now - this.cached.at < this.ttlMs) {
      return ok(this.cached.rate);
    }
    const result = await this.delegate.getRate();
    if (result.ok) {
      this.cached = { rate: result.value, at: now };
    }
    return result;
  }
}
