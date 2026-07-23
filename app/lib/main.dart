import 'dart:async';

import 'package:bmoni_transfer/core/design_system/tokens/app_spacing.dart';
import 'package:bmoni_transfer/core/theme/app_theme.dart';
import 'package:bmoni_transfer/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(LocaleSettings.useDeviceLocale());
  runApp(
    TranslationProvider(
      child: const ProviderScope(child: BmoniApp()),
    ),
  );
}

class BmoniApp extends StatelessWidget {
  const BmoniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMONI',
      debugShowCheckedModeBanner: false,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const HomePlaceholderPage(),
    );
  }
}

/// Temporary landing while the transfer feature is built. Confirms theming and
/// i18n work end to end.
class HomePlaceholderPage extends StatelessWidget {
  const HomePlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.appName,
              style: theme.textTheme.displaySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(t.tagline, style: theme.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
