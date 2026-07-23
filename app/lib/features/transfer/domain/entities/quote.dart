import 'package:bmoni_transfer/core/money/money.dart';
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
    required Money destAmount,
    required Rate rate,
    required DateTime expiresAt,
  }) = _Quote;

  bool isExpiredAt(DateTime now) => !now.isBefore(expiresAt);

  Duration remainingAt(DateTime now) {
    final remaining = expiresAt.difference(now);
    return remaining.isNegative ? Duration.zero : remaining;
  }
}
