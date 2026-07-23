/** The two currencies in this slice. Closed set as `as const` — compared by name, never magic string. */
export const Currency = {
  MXN: "MXN",
  USD: "USD",
} as const;

export type Currency = (typeof Currency)[keyof typeof Currency];

/** Number of minor-unit decimal places. Both currencies use 2 (centavos / cents). */
export const CURRENCY_EXPONENT: Record<Currency, number> = {
  MXN: 2,
  USD: 2,
};

/** Minor units per major unit, e.g. 100 for a 2-decimal currency. */
export const minorUnitScale = (currency: Currency): number => 10 ** CURRENCY_EXPONENT[currency];
