import 'dart:async';

import 'package:bmoni_transfer/core/error/error_codes.dart';
import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:bmoni_transfer/core/result/result.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:bmoni_transfer/features/transfer/presentation/providers/transfer_providers.dart';
import 'package:bmoni_transfer/shared/utils/debouncer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quote_notifier.g.dart';

// Idle is AsyncData(null); a failure carries the typed Failure as the error.
@riverpod
class QuoteNotifier extends _$QuoteNotifier {
  late final Debouncer _debouncer;
  int _requestId = 0;

  @override
  FutureOr<Quote?> build() {
    _debouncer = Debouncer(ref.read(quoteDebounceProvider));
    ref.onDispose(_debouncer.dispose);
    return null;
  }

  void onAmountChanged(String amount) {
    final trimmed = amount.trim();
    if (trimmed.isEmpty) {
      _reset();
      state = const AsyncValue<Quote?>.data(null);
      return;
    }
    final clientError = _validate(trimmed);
    if (clientError != null) {
      _reset();
      state = AsyncValue<Quote?>.error(clientError, StackTrace.current);
      return;
    }
    state = const AsyncValue<Quote?>.loading();
    _debouncer.run(() => unawaited(_fetch(trimmed)));
  }

  // Cheap gate so 0/negative/non-numeric never hit the backend (CA-17). Bounds
  // (min/max) stay authoritative on the backend, which returns the typed code.
  Failure? _validate(String amount) {
    final parsed = double.tryParse(amount);
    if (parsed == null) {
      return const ValidationFailure(
        code: ErrorCode.amountNotNumeric,
        field: FieldName.amount,
      );
    }
    if (parsed <= 0) {
      return const ValidationFailure(
        code: ErrorCode.amountNotPositive,
        field: FieldName.amount,
      );
    }
    return null;
  }

  void _reset() {
    // Invalidate any in-flight fetch so its stale reply is ignored.
    _requestId++;
    _debouncer.cancel();
  }

  Future<void> _fetch(String amount) async {
    final requestId = ++_requestId;
    final result = await ref.read(getQuoteUseCaseProvider).call(amount);
    if (requestId != _requestId) {
      return;
    }
    state = switch (result) {
      Ok(:final value) => AsyncValue<Quote?>.data(value),
      Err(:final failure) => AsyncValue<Quote?>.error(
        failure,
        StackTrace.current,
      ),
    };
  }
}
