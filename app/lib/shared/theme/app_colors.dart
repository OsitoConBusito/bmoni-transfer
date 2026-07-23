import 'package:flutter/material.dart';

/// Semantic colors Material 3's ColorScheme does not cover, tuned per
/// brightness. Money surfaces read these (never raw hex): `positive` for the
/// USD received, `fee` for the deducted fee, `warning` for expiry.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.positive,
    required this.fee,
    required this.warning,
    required this.surfaceRaised,
  });

  final Color positive;
  final Color fee;
  final Color warning;
  final Color surfaceRaised;

  static const AppColors dark = AppColors(
    positive: Color(0xFF37C2CB),
    fee: Color(0xFFA2AEBB),
    warning: Color(0xFFE0A23B),
    surfaceRaised: Color(0xFF1A222B),
  );

  static const AppColors light = AppColors(
    positive: Color(0xFF0F7A82),
    fee: Color(0xFF5A6472),
    warning: Color(0xFFB4791F),
    surfaceRaised: Color(0xFFF3F5F7),
  );

  @override
  AppColors copyWith({
    Color? positive,
    Color? fee,
    Color? warning,
    Color? surfaceRaised,
  }) {
    return AppColors(
      positive: positive ?? this.positive,
      fee: fee ?? this.fee,
      warning: warning ?? this.warning,
      surfaceRaised: surfaceRaised ?? this.surfaceRaised,
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
    );
  }
}
