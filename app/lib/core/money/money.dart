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
}
