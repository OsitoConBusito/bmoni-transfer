import 'package:bmoni_transfer/core/money/money.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fee_breakdown.freezed.dart';

/// How the fee was composed, priced by the backend so the client can explain it
/// without hardcoding the policy: `fixed` (flat part) + `variable` (percent
/// part, zero below `threshold`), plus the rule (`threshold`, percent).
@freezed
abstract class FeeBreakdown with _$FeeBreakdown {
  const FeeBreakdown._();

  const factory FeeBreakdown({
    required Money fixed,
    required Money variable,
    required Money threshold,
    required int percentBasisPoints,
  }) = _FeeBreakdown;

  /// True once the percent part kicks in (amount above the threshold).
  bool get hasVariable => variable.minorUnits > 0;

  /// The policy percent as a plain number, e.g. 100 basis points -> 1.
  double get percent => percentBasisPoints / 100;

  /// The percent without a trailing ".0": "1" for 1%, "1.5" for 1.5%.
  String get percentLabel => percent == percent.roundToDouble()
      ? percent.toStringAsFixed(0)
      : '$percent';
}
