import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:bmoni_transfer/core/money/currency.dart';
import 'package:bmoni_transfer/core/money/money.dart';
import 'package:bmoni_transfer/core/result/result.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/rate.dart';
import 'package:bmoni_transfer/features/transfer/domain/transfer_repository.dart';
import 'package:bmoni_transfer/features/transfer/presentation/notifiers/quote_notifier.dart';
import 'package:bmoni_transfer/features/transfer/presentation/providers/transfer_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements TransferRepository {}

final _quote = Quote(
  id: 'q1',
  sourceAmount: const Money(minorUnits: 100000, currency: Currency.mxn),
  fee: const Money(minorUnits: 2000, currency: Currency.mxn),
  destAmount: const Money(minorUnits: 5624, currency: Currency.usd),
  rate: const Rate(value: '0.05739', source: 'stub', asOf: '2026-07-22'),
  expiresAt: DateTime.utc(2026, 7, 22, 19, 1),
);

ProviderContainer _containerWith(TransferRepository repository) {
  final container = ProviderContainer(
    overrides: [
      transferRepositoryProvider.overrideWithValue(repository),
      quoteDebounceProvider.overrideWithValue(Duration.zero),
    ],
  );
  addTearDown(container.dispose);
  // Keep the autoDispose notifier alive so the debounced fetch runs.
  container.listen(quoteProvider, (_, _) {});
  return container;
}

void main() {
  late _MockRepository repository;

  setUp(() => repository = _MockRepository());

  test('given empty amount, when onAmountChanged, then idle', () {
    final container = _containerWith(repository);
    container.read(quoteProvider.notifier).onAmountChanged('  ');

    final state = container.read(quoteProvider);
    expect(state.hasValue, isTrue);
    expect(state.value, isNull);
  });

  test('given a valid amount, when onAmountChanged, then a quote', () async {
    when(() => repository.getQuote('1000'))
        .thenAnswer((_) async => Ok(_quote));
    final container = _containerWith(repository);

    container.read(quoteProvider.notifier).onAmountChanged('1000');
    await pumpEventQueue();

    expect(container.read(quoteProvider).value, _quote);
  });

  test('given a failing rate, when onAmountChanged, then an error', () async {
    when(() => repository.getQuote(any()))
        .thenAnswer((_) async => const Err(RateUnavailableFailure()));
    final container = _containerWith(repository);

    container.read(quoteProvider.notifier).onAmountChanged('1000');
    await pumpEventQueue();

    final state = container.read(quoteProvider);
    expect(state.hasError, isTrue);
    expect(state.error, isA<RateUnavailableFailure>());
  });
}
