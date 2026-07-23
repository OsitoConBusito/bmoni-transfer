import 'package:bmoni_transfer/core/design_system/tokens/app_spacing.dart';
import 'package:bmoni_transfer/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: BmoniApp()));
}

class BmoniApp extends StatelessWidget {
  const BmoniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMONI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const HomePlaceholderPage(),
    );
  }
}

/// Temporary landing while the transfer feature is built. Confirms theming
/// works end to end.
class HomePlaceholderPage extends StatelessWidget {
  const HomePlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'BMONI',
              style: theme.textTheme.displaySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text('MXN → USD', style: theme.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
