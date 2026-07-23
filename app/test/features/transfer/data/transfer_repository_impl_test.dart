import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:bmoni_transfer/core/result/result.dart';
import 'package:bmoni_transfer/features/transfer/data/datasources/transfer_remote_datasource.dart';
import 'package:bmoni_transfer/features/transfer/data/dtos/money_dto.dart';
import 'package:bmoni_transfer/features/transfer/data/dtos/quote_dto.dart';
import 'package:bmoni_transfer/features/transfer/data/dtos/rate_dto.dart';
import 'package:bmoni_transfer/features/transfer/data/transfer_repository_impl.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDatasource extends Mock implements TransferRemoteDatasource {}

const _quoteDto = QuoteDto(
  quoteId: 'q1',
  sourceAmount: MoneyDto(minorUnits: 100000, currency: 'MXN'),
  fee: MoneyDto(minorUnits: 2000, currency: 'MXN'),
  destAmount: MoneyDto(minorUnits: 5624, currency: 'USD'),
  rate: RateDto(value: '0.05739', source: 'stub', asOf: '2026-07-22'),
  expiresAt: '2026-07-22T19:01:00.000Z',
);

void main() {
  late _MockDatasource datasource;
  late TransferRepositoryImpl repository;

  setUp(() {
    datasource = _MockDatasource();
    repository = TransferRepositoryImpl(datasource);
  });

  test('given datasource Ok, when getQuote, then maps to a Quote', () async {
    when(() => datasource.getQuote('1000'))
        .thenAnswer((_) async => const Ok(_quoteDto));

    final result = await repository.getQuote('1000');

    expect(result, isA<Ok<Quote>>());
    expect((result as Ok<Quote>).value.destAmount.minorUnits, 5624);
  });

  test('given datasource Err, when getQuote, then propagates it', () async {
    when(() => datasource.getQuote(any()))
        .thenAnswer((_) async => const Err(NetworkFailure()));

    final result = await repository.getQuote('1000');

    expect(result, isA<Err<Quote>>());
    expect((result as Err<Quote>).failure, isA<NetworkFailure>());
  });
}
