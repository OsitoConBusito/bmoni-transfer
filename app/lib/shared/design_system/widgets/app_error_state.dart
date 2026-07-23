import 'package:bmoni_transfer/shared/design_system/tokens/app_radii.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_sizing.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_spacing.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_card.dart';
import 'package:bmoni_transfer/shared/theme/app_colors.dart';
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
    final colors = theme.extension<AppColors>();
    final tone = colors?.warning ?? theme.colorScheme.error;
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSizing.errorBadge,
            height: AppSizing.errorBadge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tone.withValues(alpha: 0.15),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.priority_high_rounded, color: tone),
          ),
          const Gap(AppSpacing.md),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
          const Gap(AppSpacing.lg),
          OutlinedButton.icon(
            onPressed: onRetry,
            icon: Icon(Icons.refresh, color: tone),
            label: Text(retryLabel),
            style: OutlinedButton.styleFrom(
              foregroundColor: tone,
              side: BorderSide(color: tone),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadii.lg),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
