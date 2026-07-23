import 'package:bmoni_transfer/shared/design_system/tokens/app_fonts.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_radii.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_sizing.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_spacing.dart';
import 'package:bmoni_transfer/shared/theme/app_colors.dart';
import 'package:bmoni_transfer/shared/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Light and dark themes built from the BMONI design. Dark-first (the design's
/// primary skin); light is a faithful twin. The seed generates the tonal
/// palette; the design's exact surface/outline/error values are pinned on top
/// so Material components render on-brand out of the box.
abstract final class AppTheme {
  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    appColors: AppColors.dark,
    scheme: const ColorScheme.dark(
      primary: Color(0xFF37C2CB),
      onPrimary: Color(0xFF04262A),
      primaryContainer: Color(0xFF0E3B40),
      onPrimaryContainer: Color(0xFF9FE7EC),
      surface: Color(0xFF12181F),
      onSurface: Color(0xFFF3F5F7),
      onSurfaceVariant: Color(0xFF9AA6B2),
      outline: Color(0xFF33404D),
      outlineVariant: Color(0xFF263039),
      error: Color(0xFFF0806F),
      onError: Color(0xFF2E1A17),
    ),
  );

  static ThemeData get light => _build(
    brightness: Brightness.light,
    appColors: AppColors.light,
    scheme: const ColorScheme.light(
      primary: Color(0xFF0F7A82),
      primaryContainer: Color(0xFFD6EEF0),
      onPrimaryContainer: Color(0xFF04353A),
      onSurface: Color(0xFF1C2530),
      onSurfaceVariant: Color(0xFF5A6472),
      outline: Color(0xFFE7E3DB),
      outlineVariant: Color(0xFFE7E3DB),
      error: Color(0xFFC64A3B),
    ),
  );

  static ThemeData _build({
    required Brightness brightness,
    required AppColors appColors,
    required ColorScheme scheme,
  }) {
    final textTheme = buildTextTheme(scheme);
    final background = brightness == Brightness.dark
        ? const Color(0xFF0B0F14)
        : const Color(0xFFFBFAF7);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      fontFamily: AppFonts.body,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[appColors],
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: appColors.surfaceRaised,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.card),
          side: BorderSide(color: appColors.border),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(AppSizing.buttonHeight),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.lg),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: appColors.surfaceRaised,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
          borderSide: BorderSide(color: appColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
          borderSide: BorderSide(color: appColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
      ),
    );
  }
}
