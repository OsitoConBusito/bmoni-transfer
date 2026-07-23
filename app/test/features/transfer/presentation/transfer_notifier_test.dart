import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:bmoni_transfer/core/money/currency.dart';
import 'package:bmoni_transfer/core/money/money.dart';
import 'package:bmoni_transfer/core/result/result.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer_status.dart';
import 'package:bmoni_transfer/features/transfer/domain/transfer_repository.dart';
import 'package:bmoni_transfer/features/transfer/presentation/notifiers/transfer_notifier.dart';
import 'package:bmoni_transfer/features/transfer/presentation/providers/transfer_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements TransferRepository {}

final _transfer = Transfer(
  id: 't1',
  status: TransferStatus.completed,
  sourceAmount: const Money(minorUnits: 100000, currency: Currency.mxn),
  destAmount: const Money(minorUnits: 5624, currency: Currency.usd),
  fee: const Money(minorUnits: 2000, currency: Currency.mxn),
  createdAt: DateTime.utc(2026, 7, 22, 19),
);

ProviderContainer _containerWith(TransferRepository repository) {
  final container = ProviderContainer(
    overrides: [transferRepositoryProvider.overrideWithValue(repository)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  late _MockRepository repository;

  setUp(() => repository = _MockRepository());

  test('given idle, when submit, then succeeded', () async {
    when(
      () => repository.createTransfer(
        quoteId: any(named: 'quoteId'),
        idempotencyKey: any(named: 'idempotencyKey'),
      ),
    ).thenAnswer((_) async => Ok(_transfer));
    final container = _containerWith(repository);

    await container.read(transferProvider('q1').notifier).submit();

    expect(container.read(transferProvider('q1')).value, _transfer);
  });

  test('given a double tap, when submit twice, then one call', () async {
    var calls = 0;
    when(
      () => repository.createTransfer(
        quoteId: any(named: 'quoteId'),
        idempotencyKey: any(named: 'idempotencyKey'),
      ),
    ).thenAnswer((_) async {
      calls++;
      return Ok(_transfer);
    });
    final container = _containerWith(repository);
    final controller = container.read(
      transferProvider('q1').notifier,
    );

    await Future.wait([controller.submit(), controller.submit()]);

    expect(calls, 1);
  });

  test('given a conflict, when submit, then failed', () async {
    when(
      () => repository.createTransfer(
        quoteId: any(named: 'quoteId'),
        idempotencyKey: any(named: 'idempotencyKey'),
      ),
    ).thenAnswer(
      (_) async => const Err(ConflictFailure(code: 'QUOTE_EXPIRED')),
    );
    final container = _containerWith(repository);

    await container.read(transferProvider('q1').notifier).submit();

    final state = container.read(transferProvider('q1'));
    expect(state.hasError, isTrue);
    expect(state.error, isA<ConflictFailure>());
  });
}
