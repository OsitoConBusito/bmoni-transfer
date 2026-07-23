sealed class Failure {
  const Failure();
}

class NetworkFailure extends Failure {
  const NetworkFailure();
}

class RateUnavailableFailure extends Failure {
  const RateUnavailableFailure();
}

class ValidationFailure extends Failure {
  const ValidationFailure({required this.code, this.field});

  final String code;
  final String? field;
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required this.code});

  final String code;
}

class ConflictFailure extends Failure {
  const ConflictFailure({required this.code});

  final String code;
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure();
}
