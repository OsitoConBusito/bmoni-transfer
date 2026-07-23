import 'package:bmoni_transfer/core/env/app_config.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

/// Timeouts keep the UI responsive so the network-error state fires instead of
/// hanging when the backend is slow or unreachable.
const Duration _requestTimeout = Duration(seconds: 10);

/// The configured HTTP client, based at the versioned API prefix.
@riverpod
Dio dio(Ref ref) {
  return Dio(
    BaseOptions(
      baseUrl: '${AppConfig.baseUrl}${AppConfig.apiPrefix}',
      connectTimeout: _requestTimeout,
      receiveTimeout: _requestTimeout,
      headers: const {Headers.contentTypeHeader: Headers.jsonContentType},
    ),
  );
}
