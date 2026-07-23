import 'package:bmoni_transfer/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Light and dark themes seeded from the BMONI brand teal, with the `AppColors`
/// semantic extension attached. Design is dark-first; light is a faithful twin.
abstract final class AppTheme {
  static const Color _seed = Color(0xFF37C2CB);
  static const Color _darkScaffold = Color(0xFF0B0F14);
  static const Color _lightScaffold = Color(0xFFFBFAF7);

  static ThemeData get dark =>
      _build(Brightness.dark, AppColors.dark, _darkScaffold);

  static ThemeData get light =>
      _build(Brightness.light, AppColors.light, _lightScaffold);

  static ThemeData _build(
    Brightness brightness,
    AppColors appColors,
    Color scaffold,
  ) {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
    );
    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      extensions: <ThemeExtension<dynamic>>[appColors],
    );
  }
}
