import 'package:bmoni_transfer/core/money/currency.dart';
import 'package:bmoni_transfer/features/transfer/data/dtos/money_dto.dart';
import 'package:bmoni_transfer/features/transfer/data/dtos/quote_dto.dart';
import 'package:bmoni_transfer/features/transfer/data/dtos/rate_dto.dart';
import 'package:bmoni_transfer/features/transfer/data/dtos/transfer_dto.dart';
import 'package:bmoni_transfer/features/transfer/data/mappers/transfer_mappers.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DTO to domain mapping', () {
    test('given a QuoteDto, when toDomain, then maps money as integers', () {
      const dto = QuoteDto(
        quoteId: 'q1',
        sourceAmount: MoneyDto(minorUnits: 100000, currency: 'MXN'),
        fee: MoneyDto(minorUnits: 2000, currency: 'MXN'),
        feeBreakdown: FeeBreakdownDto(
          fixed: MoneyDto(minorUnits: 2000, currency: 'MXN'),
          variable: MoneyDto(minorUnits: 0, currency: 'MXN'),
          threshold: MoneyDto(minorUnits: 500000, currency: 'MXN'),
          percentBasisPoints: 100,
        ),
        destAmount: MoneyDto(minorUnits: 5624, currency: 'USD'),
        rate: RateDto(value: '0.05739', source: 'stub', asOf: '2026-07-22'),
        expiresAt: '2026-07-22T19:01:00.000Z',
      );

      final quote = dto.toDomain();

      expect(quote.id, 'q1');
      expect(quote.sourceAmount.minorUnits, 100000);
      expect(quote.sourceAmount.currency, Currency.mxn);
      expect(quote.destAmount.minorUnits, 5624);
      expect(quote.destAmount.currency, Currency.usd);
      expect(quote.rate.value, '0.05739');
      expect(quote.feeBreakdown.fixed.minorUnits, 2000);
      expect(quote.feeBreakdown.percentBasisPoints, 100);
      expect(quote.feeBreakdown.hasVariable, isFalse);
    });

    test('given a TransferDto, when toDomain, then maps the status enum', () {
      const dto = TransferDto(
        transferId: 't1',
        status: 'COMPLETED',
        quoteId: 'q1',
        sourceAmount: MoneyDto(minorUnits: 100000, currency: 'MXN'),
        destAmount: MoneyDto(minorUnits: 5624, currency: 'USD'),
        fee: MoneyDto(minorUnits: 2000, currency: 'MXN'),
        createdAt: '2026-07-22T19:00:30.000Z',
      );

      final transfer = dto.toDomain();

      expect(transfer.status, TransferStatus.completed);
      expect(transfer.destAmount.minorUnits, 5624);
    });
  });
}
