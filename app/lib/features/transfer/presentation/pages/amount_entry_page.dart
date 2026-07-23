import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/quote.dart';
import 'package:bmoni_transfer/features/transfer/presentation/notifiers/quote_notifier.dart';
import 'package:bmoni_transfer/features/transfer/presentation/utils/failure_message.dart';
import 'package:bmoni_transfer/i18n/strings.g.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_sizing.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_spacing.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_button.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_card.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_error_state.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_money_text.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_shimmer.dart';
import 'package:bmoni_transfer/shared/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AmountEntryPage extends ConsumerStatefulWidget {
  const AmountEntryPage({super.key});

  @override
  ConsumerState<AmountEntryPage> createState() => _AmountEntryPageState();
}

class _AmountEntryPageState extends ConsumerState<AmountEntryPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final asyncQuote = ref.watch(quoteProvider);
    final notifier = ref.read(quoteProvider.notifier);
    final error = asyncQuote.hasError ? asyncQuote.error : null;
    final fieldError = error is ValidationFailure
        ? failureMessage(translations, error)
        : null;

    return Scaffold(
      appBar: AppBar(title: Text(translations.amountEntry.title)),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
              ],
              onChanged: notifier.onAmountChanged,
              decoration: InputDecoration(
                labelText: translations.amountEntry.amountLabel,
                hintText: translations.amountEntry.amountHint,
                errorText: fieldError,
              ),
            ),
            const Gap(AppSpacing.lg),
            Expanded(
              child: asyncQuote.when(
                data: (quote) => quote == null
                    ? const SizedBox.shrink()
                    : _QuoteBreakdown(quote: quote),
                loading: () => const _QuoteShimmer(),
                error: (error, _) => error is ValidationFailure
                    ? const SizedBox.shrink()
                    : AppErrorState(
                        message: failureMessage(
                          translations,
                          error as Failure,
                        ),
                        retryLabel: translations.common.retry,
                        onRetry: () =>
                            notifier.onAmountChanged(_controller.text),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuoteBreakdown extends StatelessWidget {
  const _QuoteBreakdown({required this.quote});

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translations.amountEntry.youReceive,
                style: theme.textTheme.bodySmall,
              ),
              const Gap(AppSpacing.xs),
              AppMoneyText(
                quote.destAmount,
                style: theme.textTheme.headlineMedium,
                color: theme.colorScheme.primary,
              ),
              const Gap(AppSpacing.md),
              _Row(
                label: translations.amountEntry.rate,
                value: translations.common.rateValue(rate: quote.rate.value),
              ),
              const Gap(AppSpacing.sm),
              _Row(
                label: translations.amountEntry.fee,
                valueWidget: AppMoneyText(quote.fee),
              ),
            ],
          ),
        ),
        const Spacer(),
        AppButton(
          label: translations.amountEntry.continueCta,
          onPressed: () => context.push(AppRoute.confirmation, extra: quote),
        ),
      ],
    );
  }
}

class _QuoteShimmer extends StatelessWidget {
  const _QuoteShimmer();

  @override
  Widget build(BuildContext context) {
    return const AppShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppShimmerBox(height: AppSizing.shimmerBlock),
          Gap(AppSpacing.md),
          AppShimmerBox(height: AppSizing.shimmerLine),
          Gap(AppSpacing.sm),
          AppShimmerBox(height: AppSizing.shimmerLine),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, this.value, this.valueWidget});

  final String label;
  final String? value;
  final Widget? valueWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: theme.textTheme.bodyMedium),
        valueWidget ?? Text(value ?? '', style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
