import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer.dart';
import 'package:bmoni_transfer/features/transfer/presentation/notifiers/quote_notifier.dart';
import 'package:bmoni_transfer/features/transfer/presentation/utils/failure_message.dart';
import 'package:bmoni_transfer/i18n/strings.g.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_motion.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_radii.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_sizing.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_spacing.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_button.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_card.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_money_text.dart';
import 'package:bmoni_transfer/shared/router/app_router.dart';
import 'package:bmoni_transfer/shared/theme/app_colors.dart';
import 'package:bmoni_transfer/shared/utils/money_formatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ResultPage extends ConsumerWidget {
  const ResultPage.success(Transfer transfer, {super.key})
    : _transfer = transfer,
      _failure = null;

  const ResultPage.failure(Failure failure, {super.key})
    : _failure = failure,
      _transfer = null;

  final Transfer? _transfer;
  final Failure? _failure;

  // A new transfer must not inherit the previous one's typed amount or
  // in-flight quote. The fresh Page key (AppRoute.resetExtra) disposes the
  // old amount-entry widget, but riverpod's autoDispose grants a grace period
  // when a new listener (the new widget) subscribes in the same frame — so
  // the quote provider survives that unless invalidated explicitly here.
  void _backToStart(BuildContext context, WidgetRef ref) {
    ref.invalidate(quoteProvider);
    context.go(AppRoute.amountEntry, extra: AppRoute.resetExtra);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transfer = _transfer;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: transfer != null
              ? _Success(
                  transfer: transfer,
                  onDone: () => _backToStart(context, ref),
                )
              : _Failure(
                  failure: _failure!,
                  onRetry: () => context.pop(),
                  onDone: () => _backToStart(context, ref),
                ),
        ),
      ),
    );
  }
}

class _Success extends StatelessWidget {
  const _Success({required this.transfer, required this.onDone});

  final Transfer transfer;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();
    final positive = colors?.positive ?? theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(AppSpacing.xl),
        _Badge(icon: Icons.check_rounded, color: positive, animate: true),
        const Gap(AppSpacing.lg),
        Text(
          translations.result.sentTitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall,
        ),
        const Gap(AppSpacing.sm),
        Text(
          translations.result.recipientWillReceive,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const Gap(AppSpacing.xs),
        Center(
          child: AppMoneyText(
            transfer.destAmount,
            style: theme.textTheme.displaySmall,
            color: positive,
          ),
        ),
        const Gap(AppSpacing.md),
        Center(child: _AvailabilityPill(color: positive)),
        const Gap(AppSpacing.xl),
        _Receipt(transfer: transfer),
        const Spacer(),
        AppButton(label: translations.result.sendAnother, onPressed: onDone),
      ],
    );
  }
}

class _Failure extends StatelessWidget {
  const _Failure({
    required this.failure,
    required this.onRetry,
    required this.onDone,
  });

  final Failure failure;
  final VoidCallback onRetry;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        _Badge(icon: Icons.close_rounded, color: theme.colorScheme.error),
        const Gap(AppSpacing.lg),
        Text(
          translations.result.failureTitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall,
        ),
        const Gap(AppSpacing.sm),
        Text(
          failureMessage(translations, failure),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        AppButton(label: translations.result.retryCta, onPressed: onRetry),
        const Gap(AppSpacing.sm),
        TextButton(
          onPressed: onDone,
          child: Text(translations.result.doneCta),
        ),
      ],
    );
  }
}

// `animate` is reserved for success — failure gets no fanfare.
class _Badge extends StatelessWidget {
  const _Badge({
    required this.icon,
    required this.color,
    this.animate = false,
  });

  final IconData icon;
  final Color color;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final badge = Center(
      child: Container(
        width: AppSizing.resultBadge,
        height: AppSizing.resultBadge,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.15),
        ),
        alignment: Alignment.center,
        child: Container(
          width: AppSizing.resultBadgeInner,
          height: AppSizing.resultBadgeInner,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: Icon(icon, color: Theme.of(context).colorScheme.surface),
        ),
      ),
    );
    if (!animate) return badge;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: AppMotion.badgePop,
      curve: AppMotion.badgePopCurve,
      builder: (context, scale, child) =>
          Transform.scale(scale: scale, child: child),
      child: badge,
    );
  }
}

class _AvailabilityPill extends StatelessWidget {
  const _AvailabilityPill({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSizing.statusDot,
            height: AppSizing.statusDot,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          const Gap(AppSpacing.sm),
          Text(
            translations.result.availableIn,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Receipt extends StatelessWidget {
  const _Receipt({required this.transfer});

  final Transfer transfer;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();
    final locale = LocaleSettings.currentLocale.languageTag;
    final date = DateFormat.yMMMd(locale).add_jm().format(transfer.createdAt);
    return AppCard(
      child: Column(
        children: [
          _ReceiptRow(
            label: translations.result.reference,
            value: transfer.id,
          ),
          const Divider(height: AppSpacing.lg),
          _ReceiptRow(
            label: translations.result.youSent,
            value: transfer.sourceAmount.format(),
          ),
          const Divider(height: AppSpacing.lg),
          _ReceiptRow(
            label: translations.amountEntry.fee,
            value: '−${transfer.fee.format()}',
            valueColor: colors?.fee,
          ),
          const Divider(height: AppSpacing.lg),
          _ReceiptRow(
            label: translations.amountEntry.rate,
            value: translations.common.rateValue(rate: transfer.rate.value),
          ),
          const Divider(height: AppSpacing.lg),
          _ReceiptRow(
            label: translations.confirmation.youReceive,
            value: transfer.destAmount.format(),
            valueColor: colors?.positive,
          ),
          const Divider(height: AppSpacing.lg),
          _ReceiptRow(label: translations.result.date, value: date),
        ],
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  const _ReceiptRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const Gap(AppSpacing.md),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}
