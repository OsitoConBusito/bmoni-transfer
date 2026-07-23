import type { RateProvider, RateUnavailable } from "../../domain/ports/rate-provider.js";
import { Rate } from "../../domain/rate.js";
import { err, ok, type Result } from "../../shared/result.js";

const DEFAULT_BASE_URL = "https://api.frankfurter.dev/v1";

interface FrankfurterResponse {
  date?: string;
  rates?: { USD?: number };
}

/**
 * Live MXN -> USD rate from Frankfurter (ECB reference rates, no API key). Network failure or an
 * unusable payload is returned as a `RateUnavailable` value — try/catch here is the infra boundary.
 */
export class FrankfurterRateProvider implements RateProvider {
  constructor(
    private readonly fetchFn: typeof fetch = fetch,
    private readonly baseUrl: string = DEFAULT_BASE_URL,
  ) {}

  async getRate(): Promise<Result<Rate, RateUnavailable>> {
    try {
      const response = await this.fetchFn(`${this.baseUrl}/latest?base=MXN&symbols=USD`);
      if (!response.ok) {
        return err({ code: "RATE_UNAVAILABLE" });
      }
      const body = (await response.json()) as FrankfurterResponse;
      const usd = body.rates?.USD;
      const asOf = body.date;
      if (typeof usd !== "number" || typeof asOf !== "string") {
        return err({ code: "RATE_UNAVAILABLE" });
      }
      return ok(Rate.of(String(usd), "frankfurter", asOf));
    } catch (cause) {
      return err({ code: "RATE_UNAVAILABLE", cause });
    }
  }
}
