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
    required DateTime expiresAt,
  }) = _Quote;

  /// What actually gets converted to USD: the send minus the deducted fee.
  Money get convertedAmount => sourceAmount.minus(fee);

  bool isExpiredAt(DateTime now) => !now.isBefore(expiresAt);

  Duration remainingAt(DateTime now) {
    final remaining = expiresAt.difference(now);
    return remaining.isNegative ? Duration.zero : remaining;
  }
}
