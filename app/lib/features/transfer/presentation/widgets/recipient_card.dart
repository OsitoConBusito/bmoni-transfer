import 'package:bmoni_transfer/i18n/strings.g.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_radii.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_sizing.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_spacing.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The "send to" card. The recipient is presentational mock data — this slice
/// only quotes and confirms MXN→USD; picking/editing a recipient is out of
/// scope, so "Change" is inert. It grounds the flow visually per the design.
class RecipientCard extends StatelessWidget {
  const RecipientCard({super.key});

  static const String _name = 'María López';
  static const String _initials = 'ML';

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          const _Avatar(initials: _initials),
          const Gap(AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translations.amountEntry.recipientTo,
                  style: theme.textTheme.labelSmall,
                ),
                Text(
                  '$_name · ${translations.amountEntry.recipientAccount}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            translations.amountEntry.recipientChange,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: AppSizing.avatar,
      height: AppSizing.avatar,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Text(
        initials,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
