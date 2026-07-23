abstract final class TransferApi {
  static const String quotePath = '/quote';
  static const String transfersPath = '/transfers';
  static const String amountParam = 'amount';
  static const String quoteIdField = 'quoteId';
  static const String idempotencyKeyHeader = 'Idempotency-Key';
}
