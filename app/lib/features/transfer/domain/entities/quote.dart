import 'package:bmoni_transfer/core/money/money.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/fee_breakdown.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/rate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote.freezed.dart';

@freezed
abstract class Quote with _$Quote {
  const Quote._();

  const factory Quote({
    required String id,
    required Money sourceAmount,
    required Money fee,
    required FeeBreakdown feeBreakdown,
    required Money destAmount,
    required Rate rate,
    required DateTime createdAt,
    required DateTime expiresAt,
  }) = _Quote;

  Money get convertedAmount => sourceAmount.minus(fee);

  /// The quote's real rate-hold window (createdAt → expiresAt) — fixed
  /// regardless of when a countdown widget happens to mount, unlike deriving
  /// a "total" from whatever time is left at that moment.
  Duration get holdDuration => expiresAt.difference(createdAt);

  bool isExpiredAt(DateTime now) => !now.isBefore(expiresAt);

  Duration remainingAt(DateTime now) {
    final remaining = expiresAt.difference(now);
    return remaining.isNegative ? Duration.zero : remaining;
  }
}
