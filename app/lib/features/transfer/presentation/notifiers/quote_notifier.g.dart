// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(QuoteNotifier)
final quoteProvider = QuoteNotifierProvider._();

final class QuoteNotifierProvider
    extends $AsyncNotifierProvider<QuoteNotifier, Quote?> {
  QuoteNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quoteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quoteNotifierHash();

  @$internal
  @override
  QuoteNotifier create() => QuoteNotifier();
}

String _$quoteNotifierHash() => r'520c9e993f3404253e19a0211644894dcc96eebb';

abstract class _$QuoteNotifier extends $AsyncNotifier<Quote?> {
  FutureOr<Quote?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Quote?>, Quote?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Quote?>, Quote?>,
              AsyncValue<Quote?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
