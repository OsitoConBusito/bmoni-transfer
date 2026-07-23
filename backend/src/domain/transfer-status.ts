/** Lifecycle of a transfer. Closed set as `as const` — compared/serialized by name. */
export const TransferStatus = {
  PENDING: "PENDING",
  COMPLETED: "COMPLETED",
  FAILED: "FAILED",
  EXPIRED: "EXPIRED",
} as const;

export type TransferStatus = (typeof TransferStatus)[keyof typeof TransferStatus];
