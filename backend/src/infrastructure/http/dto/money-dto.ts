import type { Money } from "../../../domain/money.js";

/** Money on the wire: integer minor units + currency, never a decimal. Shared by all DTOs. */
export const moneyDto = (money: Money) => ({
  minorUnits: money.minorUnits,
  currency: money.currency,
});
