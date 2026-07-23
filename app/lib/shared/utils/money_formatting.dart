import 'package:bmoni_transfer/core/money/money.dart';
import 'package:intl/intl.dart';

extension MoneyFormatting on Money {
  String format() => NumberFormat.currency(
    locale: currency.locale,
    symbol: '${currency.symbol} ',
    decimalDigits: currency.decimals,
  ).format(major);
}
