/// Typed failures mapped from the backend error envelope + transport errors.
/// Mirrors the backend's AppError kinds so the UI can react per case.
sealed class Failure {
  const Failure();
}

/// No connectivity / timeout / unreachable backend.
class NetworkFailure extends Failure {
  const NetworkFailure();
}

/// Exchange rate temporarily unavailable (HTTP 503).
class RateUnavailableFailure extends Failure {
  const RateUnavailableFailure();
}

/// Input validation rejected by the backend (HTTP 400), with its wire code.
class ValidationFailure extends Failure {
  const ValidationFailure({required this.code, this.field});

  final String code;
  final String? field;
}

/// A referenced resource was not found (HTTP 404).
class NotFoundFailure extends Failure {
  const NotFoundFailure({required this.code});

  final String code;
}

/// A state conflict (HTTP 409): expired quote, reused key, already used.
class ConflictFailure extends Failure {
  const ConflictFailure({required this.code});

  final String code;
}

/// Anything unexpected (contract violation, 500, parse error).
class UnexpectedFailure extends Failure {
  const UnexpectedFailure();
}
