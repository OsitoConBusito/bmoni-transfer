import type { RateProvider, RateUnavailable } from "../../domain/ports/rate-provider.js";
import { Rate } from "../../domain/rate.js";
import { ok, type Result } from "../../shared/result.js";

/** Deterministic MXN -> USD rate. Used for tests and as a configurable offline source. */
export class StubRateProvider implements RateProvider {
  constructor(
    private readonly value = "0.05739",
    private readonly asOf = "2026-07-22",
  ) {}

  getRate(): Promise<Result<Rate, RateUnavailable>> {
    return Promise.resolve(ok(Rate.of(this.value, "stub", this.asOf)));
  }
}
