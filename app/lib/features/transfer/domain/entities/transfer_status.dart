enum TransferStatus {
  pending,
  completed,
  failed,
  expired;

  static TransferStatus fromWire(String value) {
    return switch (value) {
      'PENDING' => TransferStatus.pending,
      'COMPLETED' => TransferStatus.completed,
      'FAILED' => TransferStatus.failed,
      'EXPIRED' => TransferStatus.expired,
      _ => throw ArgumentError.value(value, 'value', 'Unknown status'),
    };
  }
}
