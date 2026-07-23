import 'dart:async';

import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:bmoni_transfer/core/money/money.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer.dart';
import 'package:bmoni_transfer/features/transfer/presentation/notifiers/transfer_notifier.dart';
import 'package:bmoni_transfer/features/transfer/presentation/pages/result_page.dart';
import 'package:bmoni_transfer/i18n/strings.g.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_spacing.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_button.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_card.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_money_text.dart';
import 'package:bmoni_transfer/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ConfirmationPage extends ConsumerStatefulWidget {
  const ConfirmationPage({required this.quote, super.key});

  final Quote quote;

  @override
  ConsumerState<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends ConsumerState<ConfirmationPage> {
  Timer? _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = widget.quote.remainingAt(DateTime.now());
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

  void _openResult(Widget page) {
    unawaited(
      Navigator.of(
        context,
      ).push(MaterialPageRoute<void>(builder: (_) => page)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final provider = transferProvider(widget.quote.id);
    final expired = _remaining == Duration.zero;

    ref.listen(provider, (_, next) {
      if (next case AsyncData(value: final Transfer transfer)) {
        _openResult(ResultPage.success(transfer));
      } else if (next case AsyncError(:final error)) {
        _openResult(ResultPage.failure(error as Failure));
      }
    });

    final isSubmitting = ref.watch(provider).isLoading;

    return Scaffold(
      appBar: AppBar(title: Text(translations.confirmation.title)),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Breakdown(quote: widget.quote),
            const Spacer(),
            if (expired)
              _ExpiredNotice(onBack: () => Navigator.of(context).pop())
            else ...[
              Text(
                translations.confirmation.expiresIn(
                  seconds: _remaining.inSeconds,
                ),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Gap(AppSpacing.md),
              AppButton(
                label: translations.confirmation.confirmCta,
                isLoading: isSubmitting,
                onPressed: () => ref.read(provider.notifier).submit(),
              ),
            ],
          ],
        ),
      ),
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
        children: [
          _Line(
            label: translations.confirmation.youSend,
            money: quote.sourceAmount,
          ),
          const Gap(AppSpacing.sm),
          _Line(
            label: translations.confirmation.fee,
            money: quote.fee,
            color: colors?.fee,
          ),
          const Gap(AppSpacing.sm),
          _TextLine(
            label: translations.confirmation.rate,
            value: '1 MXN ≈ ${quote.rate.value} USD',
          ),
          const Divider(height: AppSpacing.lg),
          _Line(
            label: translations.confirmation.youReceive,
            money: quote.destAmount,
            color: colors?.positive,
            emphasize: true,
          ),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({
    required this.label,
    required this.money,
    this.color,
    this.emphasize = false,
  });

  final String label;
  final Money money;
  final Color? color;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = emphasize
        ? theme.textTheme.titleLarge
        : theme.textTheme.bodyLarge;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: theme.textTheme.bodyMedium),
        AppMoneyText(money, style: style, color: color),
      ],
    );
  }
}

class _TextLine extends StatelessWidget {
  const _TextLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: theme.textTheme.bodyMedium),
        Text(value, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}

class _ExpiredNotice extends StatelessWidget {
  const _ExpiredNotice({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final colors = Theme.of(context).extension<AppColors>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          translations.confirmation.expiredTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: colors?.warning,
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
