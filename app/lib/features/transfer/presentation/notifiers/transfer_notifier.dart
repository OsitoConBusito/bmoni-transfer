import 'dart:async';

import 'package:bmoni_transfer/core/result/result.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer.dart';
import 'package:bmoni_transfer/features/transfer/presentation/providers/transfer_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'transfer_notifier.g.dart';

// Idle is AsyncData(null); isLoading is the double-submit barrier.
@riverpod
class TransferNotifier extends _$TransferNotifier {
  // Generated once per quote so retries of the same transfer reuse the key.
  // Not `final`: `build()` can run again on this instance on some Riverpod
  // invalidation edge cases, and a `late final` would throw "already
  // initialized" the second time (see QuoteNotifier._debouncer).
  late String _idempotencyKey;

  @override
  FutureOr<Transfer?> build(String quoteId) {
    _idempotencyKey = const Uuid().v4();
    return null;
  }

  Future<void> submit() async {
    if (state.isLoading) {
      return;
    }
    state = const AsyncValue<Transfer?>.loading();
    final result = await ref
        .read(createTransferUseCaseProvider)
        .call(quoteId: quoteId, idempotencyKey: _idempotencyKey);
    state = switch (result) {
      Ok(:final value) => AsyncValue<Transfer?>.data(value),
      Err(:final failure) => AsyncValue<Transfer?>.error(
        failure,
        StackTrace.current,
      ),
    };
  }
}
