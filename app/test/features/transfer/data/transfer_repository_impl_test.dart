import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:bmoni_transfer/core/money/currency.dart';
import 'package:bmoni_transfer/core/money/money.dart';
import 'package:bmoni_transfer/core/result/result.dart';
import 'package:bmoni_transfer/features/transfer/data/datasources/transfer_remote_datasource.dart';
import 'package:bmoni_transfer/features/transfer/data/transfer_repository_impl.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/rate.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDatasource extends Mock implements TransferRemoteDatasource {}

const _mxn = Money(minorUnits: 100000, currency: Currency.mxn);
const _fee = Money(minorUnits: 2000, currency: Currency.mxn);
const _usd = Money(minorUnits: 5624, currency: Currency.usd);
const _rate = Rate(value: '0.05739', source: 'stub', asOf: '2026-07-22');

final _quote = Quote(
  id: 'q1',
  sourceAmount: _mxn,
  fee: _fee,
  destAmount: _usd,
  rate: _rate,
  expiresAt: DateTime.utc(2026, 7, 22, 19, 1),
);

final _transfer = Transfer(
  id: 't1',
  status: TransferStatus.completed,
  sourceAmount: _mxn,
  destAmount: _usd,
  fee: _fee,
  createdAt: DateTime.utc(2026, 7, 22, 19),
);

void main() {
  late _MockDatasource datasource;
  late TransferRepositoryImpl repository;

  setUp(() {
    datasource = _MockDatasource();
    repository = TransferRepositoryImpl(datasource);
  });

  test('given Ok, when getQuote, then Quote propagates', () async {
    when(() => datasource.getQuote('1000')).thenAnswer((_) async => Ok(_quote));

    final result = await repository.getQuote('1000');

    expect((result as Ok<Quote>).value, same(_quote));
  });

  test('given Err, when getQuote, then failure propagates', () async {
    when(
      () => datasource.getQuote(any()),
    ).thenAnswer((_) async => const Err(NetworkFailure()));

    final result = await repository.getQuote('1000');

    expect(result, isA<Err<Quote>>());
  });

  test('given Ok, when createTransfer, then Transfer propagates', () async {
    when(
      () => datasource.createTransfer(
        quoteId: any(named: 'quoteId'),
        idempotencyKey: any(named: 'idempotencyKey'),
      ),
    ).thenAnswer((_) async => Ok(_transfer));

    final result = await repository.createTransfer(
      quoteId: 'q1',
      idempotencyKey: 'k1',
    );

    expect((result as Ok<Transfer>).value, same(_transfer));
  });

  test('given Err, when createTransfer, then failure propagates', () async {
    when(
      () => datasource.createTransfer(
        quoteId: any(named: 'quoteId'),
        idempotencyKey: any(named: 'idempotencyKey'),
      ),
    ).thenAnswer(
      (_) async => const Err(ConflictFailure(code: 'QUOTE_EXPIRED')),
    );

    final result = await repository.createTransfer(
      quoteId: 'q1',
      idempotencyKey: 'k1',
    );

    expect(result, isA<Err<Transfer>>());
  });
}
