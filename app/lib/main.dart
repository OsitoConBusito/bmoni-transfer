import 'dart:async';

import 'package:bmoni_transfer/features/transfer/presentation/pages/amount_entry_page.dart';
import 'package:bmoni_transfer/i18n/strings.g.dart';
import 'package:bmoni_transfer/shared/theme/app_theme.dart';
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
      home: const AmountEntryPage(),
    );
  }
}
