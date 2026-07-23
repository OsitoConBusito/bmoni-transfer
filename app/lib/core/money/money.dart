import 'package:bmoni_transfer/core/money/currency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'money.freezed.dart';

// Pure value object; formatting and wire mapping live in other layers.
@freezed
abstract class Money with _$Money {
  const Money._();

  const factory Money({
    required int minorUnits,
    required Currency currency,
  }) = _Money;

  double get major => minorUnits / currency.minorPerMajor;

  /// Subtracts same-currency money in integer minor units — no floats. Mixing
  /// currencies is a programming error, not an expected failure path.
  Money minus(Money other) {
    if (currency != other.currency) {
      throw ArgumentError('Cannot subtract ${other.currency} from $currency');
    }
    return Money(minorUnits: minorUnits - other.minorUnits, currency: currency);
  }
}
