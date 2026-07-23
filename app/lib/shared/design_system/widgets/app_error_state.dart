import 'package:bmoni_transfer/shared/design_system/tokens/app_spacing.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    required this.message,
    required this.retryLabel,
    required this.onRetry,
    super.key,
  });

  final String message;
  final String retryLabel;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error_outline, color: theme.colorScheme.error, size: 40),
        const Gap(AppSpacing.md),
        Text(message, textAlign: TextAlign.center),
        const Gap(AppSpacing.lg),
        AppButton(label: retryLabel, onPressed: onRetry),
      ],
    );
  }
}
