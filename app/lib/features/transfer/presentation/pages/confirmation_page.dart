import 'dart:async';

import 'package:bmoni_transfer/core/money/money.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer.dart';
import 'package:bmoni_transfer/features/transfer/presentation/notifiers/transfer_notifier.dart';
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
    _total = _remaining == Duration.zero
        ? const Duration(seconds: 1)
        : _remaining;
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
              _Hero(amount: widget.quote.sourceAmount),
              const Gap(AppSpacing.lg),
              _Breakdown(quote: widget.quote),
              const Gap(AppSpacing.md),
              if (!expired)
                _Countdown(remaining: _remaining, total: _total),
              const Spacer(),
              if (expired)
                _ExpiredNotice(onBack: () => context.pop())
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
  const _Hero({required this.amount});

  final Money amount;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    return Column(
      children: [
        AppSectionLabel(translations.confirmation.heroLabel),
        const Gap(AppSpacing.sm),
        AppMoneyText(
          amount,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ],
    );
  }
}

class _Breakdown extends StatelessWidget {
  const _Breakdown({required this.quote});

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
          _Line(
            label: translations.confirmation.fee,
            value: AppMoneyText(quote.fee, color: colors?.fee, negative: true),
          ),
          const Gap(AppSpacing.sm),
          _Line(
            label: translations.confirmation.converted,
            value: AppMoneyText(quote.convertedAmount),
          ),
          const Gap(AppSpacing.sm),
          _Line(
            label: translations.confirmation.rate,
            value: Text(
              translations.common.rateValue(rate: quote.rate.value),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Divider(height: AppSpacing.xl),
          _Line(
            label: translations.confirmation.youReceive,
            emphasizeLabel: true,
            value: AppMoneyText(
              quote.destAmount,
              style: theme.textTheme.headlineSmall,
              color: colors?.positive,
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
  });

  final String label;
  final Widget value;
  final bool emphasizeLabel;

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
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: emphasizeLabel ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        value,
      ],
    );
  }
}

/// The rate-hold countdown. The bar drains toward zero as the quote nears
/// expiry — a visible signal that the price is time-boxed, in the warning tone.
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

class _ExpiredNotice extends StatelessWidget {
  const _ExpiredNotice({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();
    final tone = colors?.fee ?? theme.colorScheme.error;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
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
        ),
        const Gap(AppSpacing.md),
        AppButton(
          label: translations.confirmation.backToQuote,
          onPressed: onBack,
        ),
      ],
    );
  }
}
