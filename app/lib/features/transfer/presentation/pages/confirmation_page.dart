import 'dart:async';

import 'package:bmoni_transfer/core/money/money.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer.dart';
import 'package:bmoni_transfer/features/transfer/presentation/notifiers/transfer_notifier.dart';
import 'package:bmoni_transfer/features/transfer/presentation/widgets/fee_explanation.dart';
import 'package:bmoni_transfer/i18n/strings.g.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_radii.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_sizing.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_spacing.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_button.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_card.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_money_text.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_section_label.dart';
import 'package:bmoni_transfer/shared/router/app_router.dart';
import 'package:bmoni_transfer/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ConfirmationPage extends ConsumerStatefulWidget {
  const ConfirmationPage({required this.quote, super.key});

  final Quote quote;

  @override
  ConsumerState<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends ConsumerState<ConfirmationPage> {
  Timer? _timer;
  late Duration _remaining;
  late final Duration _total;

  @override
  void initState() {
    super.initState();
    _remaining = widget.quote.remainingAt(DateTime.now());
    // The quote's real hold window (createdAt → expiresAt), not whatever time
    // happens to remain right now — re-entering this screen with the same
    // quote (e.g. back then forward without re-quoting) must not shrink the
    // countdown's 100% reference to the leftover time.
    final holdDuration = widget.quote.holdDuration;
    _total = holdDuration <= Duration.zero
        ? const Duration(seconds: 1)
        : holdDuration;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final remaining = widget.quote.remainingAt(DateTime.now());
      setState(() => _remaining = remaining);
      if (remaining == Duration.zero) {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _openResult(Object outcome) {
    // On success the quote is consumed: replace confirmation so the OS back
    // gesture can't return to a dead quote. On failure keep it for retry.
    if (outcome is Transfer) {
      context.pushReplacement(AppRoute.result, extra: outcome);
    } else {
      unawaited(context.push(AppRoute.result, extra: outcome));
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final provider = transferProvider(widget.quote.id);
    final expired = _remaining == Duration.zero;

    ref.listen(provider, (_, next) {
      if (next case AsyncData(value: final Transfer transfer)) {
        _openResult(transfer);
      } else if (next case AsyncError(:final error)) {
        _openResult(error);
      }
    });

    final isSubmitting = ref.watch(provider).isLoading;

    return Scaffold(
      appBar: AppBar(title: Text(translations.confirmation.title)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Hero(amount: widget.quote.sourceAmount, dimmed: expired),
              const Gap(AppSpacing.lg),
              _Breakdown(quote: widget.quote, dimmed: expired),
              const Gap(AppSpacing.md),
              if (expired)
                const _ExpiredNotice()
              else
                _Countdown(remaining: _remaining, total: _total),
              const Spacer(),
              if (expired)
                AppButton(
                  label: translations.confirmation.backToQuote,
                  icon: Icons.refresh,
                  onPressed: () => context.pop(),
                )
              else
                AppButton(
                  label: translations.confirmation.confirmCta,
                  isLoading: isSubmitting,
                  loadingLabel: translations.confirmation.sending,
                  onPressed: () => ref.read(provider.notifier).submit(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.amount, required this.dimmed});

  final Money amount;

  /// A stale (expired) quote: the big amount drops to `disabledEmphasis`
  /// gray instead of its normal color — the section label stays as-is.
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();
    return Column(
      children: [
        AppSectionLabel(translations.confirmation.heroLabel),
        const Gap(AppSpacing.sm),
        AppMoneyText(
          amount,
          style: theme.textTheme.displaySmall,
          color: dimmed ? colors?.disabledEmphasis : null,
        ),
      ],
    );
  }
}

class _Breakdown extends StatelessWidget {
  const _Breakdown({required this.quote, required this.dimmed});

  final Quote quote;

  /// A stale (expired) quote: every label/value collapses to `disabled` gray
  /// (the big "recipient gets" amount to `disabledEmphasis`) instead of the
  /// normal fee/positive colors — matching the design rather than just
  /// lowering opacity uniformly.
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();
    final muted = dimmed ? colors?.disabled : null;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Line(
            label: translations.confirmation.fee,
            labelColor: muted,
            value: AppMoneyText(
              quote.fee,
              color: muted ?? colors?.fee,
              negative: true,
            ),
          ),
          const Gap(AppSpacing.xs),
          Align(
            alignment: Alignment.centerLeft,
            child: FeeExplanation(breakdown: quote.feeBreakdown, color: muted),
          ),
          const Gap(AppSpacing.sm),
          _Line(
            label: translations.confirmation.converted,
            labelColor: muted,
            value: AppMoneyText(quote.convertedAmount, color: muted),
          ),
          const Gap(AppSpacing.sm),
          _Line(
            label: translations.confirmation.rate,
            labelColor: muted,
            value: Text(
              translations.common.rateValue(rate: quote.rate.value),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: muted,
              ),
            ),
          ),
          const Divider(height: AppSpacing.xl),
          _Line(
            label: translations.confirmation.youReceive,
            emphasizeLabel: true,
            labelColor: muted,
            value: AppMoneyText(
              quote.destAmount,
              style: theme.textTheme.headlineSmall,
              color: dimmed ? colors?.disabledEmphasis : colors?.positive,
            ),
          ),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({
    required this.label,
    required this.value,
    this.emphasizeLabel = false,
    this.labelColor,
  });

  final String label;
  final Widget value;
  final bool emphasizeLabel;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: labelColor ?? theme.colorScheme.onSurfaceVariant,
            fontWeight: emphasizeLabel ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        value,
      ],
    );
  }
}

class _Countdown extends StatelessWidget {
  const _Countdown({required this.remaining, required this.total});

  final Duration remaining;
  final Duration total;

  String _formatted(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);
    final warning = theme.extension<AppColors>()?.warning ?? theme.hintColor;
    final progress = total.inSeconds == 0
        ? 0.0
        : remaining.inSeconds / total.inSeconds;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  translations.confirmation.rateHold,
                  style: theme.textTheme.bodyMedium?.copyWith(color: warning),
                ),
              ),
              Text(
                _formatted(remaining),
                style: theme.textTheme.titleMedium?.copyWith(color: warning),
              ),
            ],
          ),
          const Gap(AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.sm),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: AppSizing.countdownBar,
              backgroundColor: warning.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(warning),
            ),
          ),
        ],
      ),
    );
  }
}

// The retry CTA lives separately, pinned at the screen bottom.
class _ExpiredNotice extends StatelessWidget {
  const _ExpiredNotice();

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();
    final tone = colors?.fee ?? theme.colorScheme.error;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(color: tone.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translations.confirmation.expiredTitle,
            style: theme.textTheme.titleMedium?.copyWith(color: tone),
          ),
          const Gap(AppSpacing.xs),
          Text(
            translations.confirmation.expiredBody,
            style: theme.textTheme.bodyMedium?.copyWith(color: tone),
          ),
        ],
      ),
    );
  }
}
