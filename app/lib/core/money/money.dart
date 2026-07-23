import 'package:bmoni_transfer/core/money/currency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'money.freezed.dart';

/// Money as integer minor units + currency — a pure domain value object that
/// mirrors the backend. The client never does money math (the backend is
/// authoritative). Formatting (intl/locale) is a presentation concern and lives
/// in a presentation extension; wire mapping lives in the data layer.
@freezed
abstract class Money with _$Money {
  const Money._();

  const factory Money({
    required int minorUnits,
    required Currency currency,
  }) = _Money;

  /// Major-unit value, e.g. 5624 cents -> 56.24. Arithmetic, not display.
  double get major => minorUnits / currency.minorPerMajor;
}
