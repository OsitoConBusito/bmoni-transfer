import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:bmoni_transfer/features/transfer/presentation/widgets/fee_explanation.dart';
import 'package:bmoni_transfer/i18n/strings.g.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_sizing.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_spacing.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_card.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_money_text.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_shimmer.dart';
import 'package:bmoni_transfer/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The live quote breakdown: rate, deducted fee, and the USD the recipient
/// gets. The received amount is the emphasized, positive-colored hero of the
/// card; the fee reads negative. Money never gets recomputed here — it is shown
/// exactly as the backend priced it.
class QuoteCard extends StatelessWidget {
  const QuoteCard({required this.quote, super.key});

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _RateRow(
            value: translations.common.rateValue(rate: quote.rate.value),
          ),
          const Gap(AppSpacing.md),
          _Row(
            label: translations.amountEntry.fee,
            value: AppMoneyText(
              quote.fee,
              color: colors?.fee,
              negative: true,
            ),
          ),
          const Gap(AppSpacing.xs),
          FeeExplanation(breakdown: quote.feeBreakdown),
          const Divider(height: AppSpacing.xl),
          _Row(
            label: translations.amountEntry.youReceive,
            emphasizeLabel: true,
            value: AppMoneyText(
              quote.destAmount,
              style: theme.textTheme.headlineMedium,
              color: colors?.positive,
            ),
          ),
        ],
      ),
    );
  }
}

class _RateRow extends StatelessWidget {
  const _RateRow({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          translations.amountEntry.rate,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Row(
          children: [
            Container(
              width: AppSizing.statusDot,
              height: AppSizing.statusDot,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors?.positive ?? theme.colorScheme.primary,
              ),
            ),
            const Gap(AppSpacing.sm),
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.value,
    this.emphasizeLabel = false,
  });

  final String label;
  final Widget value;
  final bool emphasizeLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
      fontWeight: emphasizeLabel ? FontWeight.w600 : FontWeight.w400,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label, style: labelStyle),
        value,
      ],
    );
  }
}

class QuoteCardShimmer extends StatelessWidget {
  const QuoteCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppCard(
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppShimmerBox(height: AppSizing.shimmerLine),
            Gap(AppSpacing.md),
            AppShimmerBox(height: AppSizing.shimmerLine),
            Gap(AppSpacing.lg),
            AppShimmerBox(height: AppSizing.shimmerBlock),
          ],
        ),
      ),
    );
  }
}
