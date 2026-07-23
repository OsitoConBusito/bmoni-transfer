import 'package:bmoni_transfer/shared/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

// Bounded so a slow/unreachable backend surfaces the network-error state.
const Duration _requestTimeout = Duration(seconds: 10);

@riverpod
Dio dio(Ref ref) {
  final client = Dio(
    BaseOptions(
      baseUrl: '${AppConfig.baseUrl}${AppConfig.apiPrefix}',
      connectTimeout: _requestTimeout,
      receiveTimeout: _requestTimeout,
      headers: const {Headers.contentTypeHeader: Headers.jsonContentType},
    ),
  );

  if (kDebugMode) {
    client.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => debugPrint(object.toString()),
      ),
    );
  }

  return client;
}
