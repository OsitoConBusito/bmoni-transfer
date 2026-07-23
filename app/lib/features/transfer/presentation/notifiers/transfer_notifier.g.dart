// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TransferNotifier)
final transferProvider = TransferNotifierFamily._();

final class TransferNotifierProvider
    extends $AsyncNotifierProvider<TransferNotifier, Transfer?> {
  TransferNotifierProvider._({
    required TransferNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'transferProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$transferNotifierHash();

  @override
  String toString() {
    return r'transferProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TransferNotifier create() => TransferNotifier();

  @override
  bool operator ==(Object other) {
    return other is TransferNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$transferNotifierHash() => r'ff6f8a39d160001d453f4809b0d8ea6bd50be88a';

final class TransferNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          TransferNotifier,
          AsyncValue<Transfer?>,
          Transfer?,
          FutureOr<Transfer?>,
          String
        > {
  TransferNotifierFamily._()
    : super(
        retry: null,
        name: r'transferProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TransferNotifierProvider call(String quoteId) =>
      TransferNotifierProvider._(argument: quoteId, from: this);

  @override
  String toString() => r'transferProvider';
}

abstract class _$TransferNotifier extends $AsyncNotifier<Transfer?> {
  late final _$args = ref.$arg as String;
  String get quoteId => _$args;

  FutureOr<Transfer?> build(String quoteId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Transfer?>, Transfer?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Transfer?>, Transfer?>,
              AsyncValue<Transfer?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
