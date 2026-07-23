/** Raised when a rate is constructed from an invalid value. Programming/infra error, not a domain path. */
export class RateError extends Error {}

/**
 * An FX rate as an exact scaled integer, never a float. "0.05739" is stored as
 * scaledValue=5739, scale=100000 so `Money.applyRate` can multiply with integer math.
 * Direction is MXN → USD in this slice.
 */
export class Rate {
  private constructor(
    readonly value: string,
    readonly scaledValue: bigint,
    readonly scale: bigint,
    readonly source: string,
    readonly asOf: string,
  ) {}

  static of(value: string, source: string, asOf: string): Rate {
    const trimmed = value.trim();
    if (!/^\d+(\.\d+)?$/.test(trimmed)) {
      throw new RateError(`Rate value "${value}" is not a positive decimal`);
    }
    const [intPart = "0", fracPart = ""] = trimmed.split(".");
    const scale = 10n ** BigInt(fracPart.length);
    const scaledValue = BigInt(intPart) * scale + (fracPart === "" ? 0n : BigInt(fracPart));
    if (scaledValue <= 0n) {
      throw new RateError(`Rate value "${value}" must be greater than zero`);
    }
    return new Rate(trimmed, scaledValue, scale, source, asOf);
  }
}
