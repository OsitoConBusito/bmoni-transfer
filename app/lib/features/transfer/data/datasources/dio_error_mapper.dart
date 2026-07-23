import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:dio/dio.dart';

const _badRequest = 400;
const _notFound = 404;
const _conflict = 409;
const _serviceUnavailable = 503;

Failure mapDioError(DioException error) {
  final response = error.response;
  if (response == null) {
    return const NetworkFailure();
  }
  final code = _readCode(response.data);
  return switch (response.statusCode) {
    _badRequest => ValidationFailure(
      code: code,
      field: _readField(response.data),
    ),
    _notFound => NotFoundFailure(code: code),
    _conflict => ConflictFailure(code: code),
    _serviceUnavailable => const RateUnavailableFailure(),
    _ => const UnexpectedFailure(),
  };
}

Map<String, dynamic>? _errorEnvelope(Object? data) {
  if (data is Map<String, dynamic> && data['error'] is Map<String, dynamic>) {
    return data['error'] as Map<String, dynamic>;
  }
  return null;
}

String _readCode(Object? data) =>
    _errorEnvelope(data)?['code'] as String? ?? 'UNKNOWN';

String? _readField(Object? data) =>
    _errorEnvelope(data)?['field'] as String?;
