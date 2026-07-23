import 'package:bmoni_transfer/core/money/currency.dart';
import 'package:bmoni_transfer/core/money/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Money.minus', () {
    test('given same currency, when minus, then subtracts minor units', () {
      const send = Money(minorUnits: 500000, currency: Currency.mxn);
      const fee = Money(minorUnits: 2000, currency: Currency.mxn);

      expect(
        send.minus(fee),
        const Money(minorUnits: 498000, currency: Currency.mxn),
      );
    });

    test('given mixed currencies, when minus, then throws', () {
      const mxn = Money(minorUnits: 500000, currency: Currency.mxn);
      const usd = Money(minorUnits: 100, currency: Currency.usd);

      expect(() => mxn.minus(usd), throwsArgumentError);
    });
  });
}
