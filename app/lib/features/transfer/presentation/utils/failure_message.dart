import 'package:bmoni_transfer/core/error/error_codes.dart';
import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:bmoni_transfer/i18n/strings.g.dart';

// Maps a typed Failure to a localized message. The raw wire message is never
// shown; the client owns the copy per error code.
String failureMessage(Translations translations, Failure failure) {
  return switch (failure) {
    NetworkFailure() => translations.errors.network,
    RateUnavailableFailure() => translations.errors.rateUnavailable,
    NotFoundFailure() => translations.errors.unexpected,
    UnexpectedFailure() => translations.errors.unexpected,
    ValidationFailure(:final code) => _byValidationCode(translations, code),
    ConflictFailure(:final code) => _byConflictCode(translations, code),
  };
}

String _byValidationCode(Translations translations, String code) =>
    switch (code) {
      ErrorCode.amountNotNumeric => translations.errors.amountNotNumeric,
      ErrorCode.amountNotPositive => translations.errors.amountNotPositive,
      ErrorCode.amountTooLow => translations.errors.amountTooLow,
      ErrorCode.amountTooHigh => translations.errors.amountTooHigh,
      ErrorCode.amountBelowFee => translations.errors.amountBelowFee,
      _ => translations.errors.unexpected,
    };

String _byConflictCode(Translations translations, String code) =>
    switch (code) {
      ErrorCode.quoteExpired => translations.errors.quoteExpired,
      _ => translations.errors.unexpected,
    };
