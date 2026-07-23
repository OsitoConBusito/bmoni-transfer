import 'package:bmoni_transfer/core/money/money.dart';
import 'package:intl/intl.dart';

extension MoneyFormatting on Money {
  /// Formats as "$267.84 USD": a "$" symbol with the ISO code as suffix, per
  /// the design — the code (not a "US$"/"MX$" prefix) disambiguates currency.
  /// Pass `withCode: false` for the bare "$267.84" where a nearby label already
  /// names the currency (the amount-entry hero).
  String format({bool withCode = true}) {
    final amount = NumberFormat.currency(
      locale: currency.locale,
      symbol: r'$',
      decimalDigits: currency.decimals,
    ).format(major);
    return withCode ? '$amount ${currency.code}' : amount;
  }
}
