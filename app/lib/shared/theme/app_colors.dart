import 'package:flutter/material.dart';

/// Semantic colors Material 3's ColorScheme does not cover, tuned per
/// brightness and taken from the BMONI design. Money surfaces read these
/// (never raw hex): `positive` for the USD received, `fee` for the deducted
/// fee (shown as −$), `warning` for expiry, `surfaceRaised`/`border` for cards.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.positive,
    required this.fee,
    required this.warning,
    required this.surfaceRaised,
    required this.border,
  });

  final Color positive;
  final Color fee;
  final Color warning;
  final Color surfaceRaised;
  final Color border;

  static const AppColors dark = AppColors(
    positive: Color(0xFF46C97E),
    fee: Color(0xFFF0806F),
    warning: Color(0xFFE8B84B),
    surfaceRaised: Color(0xFF1A222B),
    border: Color(0xFF263039),
  );

  static const AppColors light = AppColors(
    positive: Color(0xFF1A8A4E),
    fee: Color(0xFFC64A3B),
    warning: Color(0xFFC98A18),
    surfaceRaised: Color(0xFFFFFFFF),
    border: Color(0xFFE7E3DB),
  );

  @override
  AppColors copyWith({
    Color? positive,
    Color? fee,
    Color? warning,
    Color? surfaceRaised,
    Color? border,
  }) {
    return AppColors(
      positive: positive ?? this.positive,
      fee: fee ?? this.fee,
      warning: warning ?? this.warning,
      surfaceRaised: surfaceRaised ?? this.surfaceRaised,
      border: border ?? this.border,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      positive: Color.lerp(positive, other.positive, t)!,
      fee: Color.lerp(fee, other.fee, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      surfaceRaised: Color.lerp(surfaceRaised, other.surfaceRaised, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }
}
