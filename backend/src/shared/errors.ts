/** Wire error codes as a closed set — compared/sent by name, never a magic string. Grows per feature. */
export const ErrorCode = {
  AMOUNT_REQUIRED: "AMOUNT_REQUIRED",
  AMOUNT_NOT_NUMERIC: "AMOUNT_NOT_NUMERIC",
  AMOUNT_NOT_POSITIVE: "AMOUNT_NOT_POSITIVE",
  AMOUNT_TOO_LOW: "AMOUNT_TOO_LOW",
  AMOUNT_TOO_HIGH: "AMOUNT_TOO_HIGH",
  AMOUNT_BELOW_FEE: "AMOUNT_BELOW_FEE",
  RATE_UNAVAILABLE: "RATE_UNAVAILABLE",
  QUOTE_ID_REQUIRED: "QUOTE_ID_REQUIRED",
  IDEMPOTENCY_KEY_REQUIRED: "IDEMPOTENCY_KEY_REQUIRED",
  QUOTE_NOT_FOUND: "QUOTE_NOT_FOUND",
  QUOTE_EXPIRED: "QUOTE_EXPIRED",
  QUOTE_ALREADY_USED: "QUOTE_ALREADY_USED",
  IDEMPOTENCY_KEY_REUSED: "IDEMPOTENCY_KEY_REUSED",
  QUOTE_TAMPERED: "QUOTE_TAMPERED",
} as const;

export type ErrorCode = (typeof ErrorCode)[keyof typeof ErrorCode];

/**
 * Expected failures as a typed value. `kind` decides the HTTP status at the edge; `code` is the
 * stable wire code the client maps to a message. Never leaks internals.
 */
export type AppError =
  | {
      readonly kind: "validation";
      readonly code: ErrorCode;
      readonly message: string;
      readonly field?: string;
    }
  | { readonly kind: "unavailable"; readonly code: ErrorCode; readonly message: string }
  | { readonly kind: "not_found"; readonly code: ErrorCode; readonly message: string }
  | { readonly kind: "conflict"; readonly code: ErrorCode; readonly message: string };

export const validationError = (code: ErrorCode, message: string, field?: string): AppError =>
  field === undefined
    ? { kind: "validation", code, message }
    : { kind: "validation", code, message, field };

export const unavailableError = (code: ErrorCode, message: string): AppError => ({
  kind: "unavailable",
  code,
  message,
});

export const notFoundError = (code: ErrorCode, message: string): AppError => ({
  kind: "not_found",
  code,
  message,
});

export const conflictError = (code: ErrorCode, message: string): AppError => ({
  kind: "conflict",
  code,
  message,
});
