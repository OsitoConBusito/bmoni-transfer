import 'package:bmoni_transfer/shared/design_system/tokens/app_fonts.dart';
import 'package:flutter/material.dart';

/// Tabular figures keep money columns aligned as digits change. Applied to
/// every numeric surface (amounts, rate, fee) so they never jitter.
const List<FontFeature> tabularFigures = [FontFeature.tabularFigures()];

/// The BMONI type scale. `display`/`headline`/`title` ride Space Grotesk (the
/// numeric, characterful face); `body`/`label` ride Plus Jakarta Sans. Colors
/// resolve from the scheme so the same scale works in light and dark.
TextTheme buildTextTheme(ColorScheme scheme) {
  final ink = scheme.onSurface;
  final muted = scheme.onSurfaceVariant;

  TextStyle display(double size, {double spacing = -1, Color? color}) =>
      TextStyle(
        fontFamily: AppFonts.display,
        fontWeight: FontWeight.w700,
        fontSize: size,
        letterSpacing: spacing,
        height: 1.1,
        color: color ?? ink,
      );

  TextStyle body(double size, {FontWeight weight = FontWeight.w400}) =>
      TextStyle(
        fontFamily: AppFonts.body,
        fontWeight: weight,
        fontSize: size,
        height: 1.45,
        color: ink,
      );

  return TextTheme(
    displayLarge: display(44, spacing: -1.2),
    displayMedium: display(36),
    displaySmall: display(30, spacing: -0.6),
    headlineMedium: display(26, spacing: -0.5),
    headlineSmall: display(22, spacing: -0.5),
    titleLarge: display(20, spacing: -0.4),
    titleMedium: body(16, weight: FontWeight.w600),
    bodyLarge: body(16),
    bodyMedium: body(14),
    bodySmall: body(13, weight: FontWeight.w500).copyWith(color: muted),
    labelLarge: body(15, weight: FontWeight.w700),
    labelMedium: body(13, weight: FontWeight.w600).copyWith(color: muted),
    labelSmall: body(12, weight: FontWeight.w600).copyWith(color: muted),
  );
}
