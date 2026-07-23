import 'package:bmoni_transfer/core/money/currency.dart';
import 'package:bmoni_transfer/core/money/money.dart';
import 'package:bmoni_transfer/shared/utils/money_formatting.dart';
import 'package:flutter/services.dart';

/// Formats a numeric field as currency while typing: digits accumulate from the
/// right as minor units, so "500000" reads as "MX$ 5,000.00". Pair it with
/// [FilteringTextInputFormatter.digitsOnly]. Use [cleanMajorFrom] in the
/// field's `onChanged` to recover the plain major-unit string the domain wants.
class CurrencyInputFormatter extends TextInputFormatter {
  const CurrencyInputFormatter(this.currency);

  final Currency currency;

  /// Guards against int overflow on absurd input; far above any real amount.
  static const int _maxDigits = 12;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = _digitsOf(newValue.text);
    if (digits.isEmpty) return TextEditingValue.empty;
    final text = Money(
      minorUnits: int.parse(digits),
      currency: currency,
    ).format(withCode: false);
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  /// The major-unit value (e.g. "5000.00") behind the formatted text, or an
  /// empty string when there is no input yet.
  String cleanMajorFrom(String formatted) {
    final digits = _digitsOf(formatted);
    if (digits.isEmpty) return '';
    final major = int.parse(digits) / currency.minorPerMajor;
    return major.toStringAsFixed(currency.decimals);
  }

  String _digitsOf(String text) {
    final digits = text.replaceAll(RegExp('[^0-9]'), '');
    return digits.length > _maxDigits
        ? digits.substring(0, _maxDigits)
        : digits;
  }
}
