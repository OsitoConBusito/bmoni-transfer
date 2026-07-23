// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(transferRemoteDatasource)
final transferRemoteDatasourceProvider = TransferRemoteDatasourceProvider._();

final class TransferRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          TransferRemoteDatasource,
          TransferRemoteDatasource,
          TransferRemoteDatasource
        >
    with $Provider<TransferRemoteDatasource> {
  TransferRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transferRemoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transferRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<TransferRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TransferRemoteDatasource create(Ref ref) {
    return transferRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransferRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransferRemoteDatasource>(value),
    );
  }
}

String _$transferRemoteDatasourceHash() =>
    r'9857b48a58cf15fc3da92d0dc3a69a9b15a7e930';

@ProviderFor(transferRepository)
final transferRepositoryProvider = TransferRepositoryProvider._();

final class TransferRepositoryProvider
    extends
        $FunctionalProvider<
          TransferRepository,
          TransferRepository,
          TransferRepository
        >
    with $Provider<TransferRepository> {
  TransferRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transferRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transferRepositoryHash();

  @$internal
  @override
  $ProviderElement<TransferRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TransferRepository create(Ref ref) {
    return transferRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransferRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransferRepository>(value),
    );
  }
}

String _$transferRepositoryHash() =>
    r'4b32d8318a87cf0a39a7133d9828957170d0d321';

@ProviderFor(getQuoteUseCase)
final getQuoteUseCaseProvider = GetQuoteUseCaseProvider._();

final class GetQuoteUseCaseProvider
    extends $FunctionalProvider<GetQuote, GetQuote, GetQuote>
    with $Provider<GetQuote> {
  GetQuoteUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getQuoteUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getQuoteUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetQuote> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetQuote create(Ref ref) {
    return getQuoteUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetQuote value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetQuote>(value),
    );
  }
}

String _$getQuoteUseCaseHash() => r'7c0afb12efb19e38b02214611d2ea32cd09d8944';

@ProviderFor(createTransferUseCase)
final createTransferUseCaseProvider = CreateTransferUseCaseProvider._();

final class CreateTransferUseCaseProvider
    extends $FunctionalProvider<CreateTransfer, CreateTransfer, CreateTransfer>
    with $Provider<CreateTransfer> {
  CreateTransferUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createTransferUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createTransferUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateTransfer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CreateTransfer create(Ref ref) {
    return createTransferUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateTransfer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateTransfer>(value),
    );
  }
}

String _$createTransferUseCaseHash() =>
    r'082f36c7adbffa0325ae4e0698c536d404e277fd';

@ProviderFor(quoteDebounce)
final quoteDebounceProvider = QuoteDebounceProvider._();

final class QuoteDebounceProvider
    extends $FunctionalProvider<Duration, Duration, Duration>
    with $Provider<Duration> {
  QuoteDebounceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quoteDebounceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quoteDebounceHash();

  @$internal
  @override
  $ProviderElement<Duration> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Duration create(Ref ref) {
    return quoteDebounce(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration>(value),
    );
  }
}

String _$quoteDebounceHash() => r'404f40e710dadc593297541c5b0f70bc6bbc9ba8';
