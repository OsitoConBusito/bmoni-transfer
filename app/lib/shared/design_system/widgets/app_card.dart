import 'package:bmoni_transfer/shared/design_system/tokens/app_radii.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_spacing.dart';
import 'package:bmoni_transfer/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final raised = theme.extension<AppColors>()?.surfaceRaised;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: raised ?? theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: child,
    );
  }
}
