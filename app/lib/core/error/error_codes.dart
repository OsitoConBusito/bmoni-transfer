// Wire field names for validation errors. A single field today; a named
// constant (not an enum) until the form has fields we branch on.
abstract final class FieldName {
  static const String amount = 'amount';
}

// Wire error codes, mirroring the backend contract (backend shared/errors.ts).
abstract final class ErrorCode {
  static const String amountRequired = 'AMOUNT_REQUIRED';
  static const String amountNotNumeric = 'AMOUNT_NOT_NUMERIC';
  static const String amountNotPositive = 'AMOUNT_NOT_POSITIVE';
  static const String amountTooLow = 'AMOUNT_TOO_LOW';
  static const String amountTooHigh = 'AMOUNT_TOO_HIGH';
  static const String amountBelowFee = 'AMOUNT_BELOW_FEE';
  static const String rateUnavailable = 'RATE_UNAVAILABLE';
  static const String quoteExpired = 'QUOTE_EXPIRED';
  static const String quoteNotFound = 'QUOTE_NOT_FOUND';
  static const String quoteAlreadyUsed = 'QUOTE_ALREADY_USED';
  static const String idempotencyKeyReused = 'IDEMPOTENCY_KEY_REUSED';
  static const String quoteTampered = 'QUOTE_TAMPERED';
}
