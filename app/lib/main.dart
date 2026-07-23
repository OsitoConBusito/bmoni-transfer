import 'dart:async';

import 'package:bmoni_transfer/i18n/strings.g.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_spacing.dart';
import 'package:bmoni_transfer/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

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

class HomePlaceholderPage extends StatelessWidget {
  const HomePlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translations = Translations.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              translations.appName,
              style: theme.textTheme.displaySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const Gap(AppSpacing.sm),
            Text(translations.tagline, style: theme.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
