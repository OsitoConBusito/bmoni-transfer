import type { Result } from "../../shared/result.js";
import type { Rate } from "../rate.js";

/** The FX source is unreachable or returned an unusable payload. Mapped to 503 at the edge. */
export interface RateUnavailable {
  readonly code: "RATE_UNAVAILABLE";
  readonly cause?: unknown;
}

/** Port for the MXN -> USD rate source. Implementations: Frankfurter (live), Stub, Cached. */
export interface RateProvider {
  getRate(): Promise<Result<Rate, RateUnavailable>>;
}
