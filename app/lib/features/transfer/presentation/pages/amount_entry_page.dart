import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:bmoni_transfer/core/money/currency.dart';
import 'package:bmoni_transfer/core/money/money.dart';
import 'package:bmoni_transfer/features/transfer/presentation/notifiers/quote_notifier.dart';
import 'package:bmoni_transfer/features/transfer/presentation/utils/failure_message.dart';
import 'package:bmoni_transfer/features/transfer/presentation/widgets/quote_card.dart';
import 'package:bmoni_transfer/features/transfer/presentation/widgets/recipient_card.dart';
import 'package:bmoni_transfer/i18n/strings.g.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_radii.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_spacing.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_button.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_error_state.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_section_label.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/dashed_border.dart';
import 'package:bmoni_transfer/shared/router/app_router.dart';
import 'package:bmoni_transfer/shared/theme/app_colors.dart';
import 'package:bmoni_transfer/shared/theme/app_typography.dart';
import 'package:bmoni_transfer/shared/utils/currency_input_formatter.dart';
import 'package:bmoni_transfer/shared/utils/end_cursor_text_controller.dart';
import 'package:bmoni_transfer/shared/utils/money_formatting.dart';
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
  final _controller = EndCursorTextEditingController();
  final _formatter = const CurrencyInputFormatter(Currency.mxn);

  @override
  void initState() {
    super.initState();
    // quoteProvider outlives this widget (it's a Riverpod provider, not
    // widget state): if this instance mounts while a quote already exists —
    // e.g. returning here and the widget happens to get recreated — the
    // field must show the amount that produced it, not start blank while the
    // quote card below still shows stale-looking data for "no amount".
    final asyncQuote = ref.read(quoteProvider);
    final quote = switch (asyncQuote) {
      AsyncData(:final value) => value,
      _ => null,
    };
    if (quote != null) {
      _controller.text = quote.sourceAmount.format(withCode: false);
    }
  }

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
    final quote = switch (asyncQuote) {
      AsyncData(:final value) => value,
      _ => null,
    };

    final error = asyncQuote.hasError ? asyncQuote.error : null;
    final fieldError = error is ValidationFailure
        ? failureMessage(translations, error)
        : null;

    return Scaffold(
      appBar: AppBar(title: Text(translations.amountEntry.title)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Scrolls so the keyboard can't overflow this content.
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const RecipientCard(),
                      const Gap(AppSpacing.lg),
                      _AmountHero(
                        controller: _controller,
                        formatter: _formatter,
                        onAmountChanged: notifier.onAmountChanged,
                        errorText: fieldError,
                      ),
                      const Gap(AppSpacing.xl),
                      asyncQuote.when(
                        data: (quote) => quote == null
                            ? const _QuoteEmpty()
                            : QuoteCard(quote: quote),
                        loading: () => const QuoteCardShimmer(),
                        error: (error, _) => error is ValidationFailure
                            ? const _QuoteEmpty()
                            : AppErrorState(
                                // The state's error is only ever a Failure in
                                // practice (see QuoteNotifier), but this is a
                                // presentation boundary reading whatever
                                // AsyncValue.error surfaces — never trust that
                                // blindly with a force cast; fall back to a
                                // generic message instead of crashing.
                                message: failureMessage(
                                  translations,
                                  error is Failure
                                      ? error
                                      : const UnexpectedFailure(),
                                ),
                                retryLabel: translations.common.retry,
                                onRetry: () => notifier.onAmountChanged(
                                  _formatter.cleanMajorFrom(_controller.text),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(AppSpacing.md),
              AppButton(
                label: translations.amountEntry.continueCta,
                onPressed: quote == null
                    ? null
                    : () => context.push(AppRoute.confirmation, extra: quote),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AmountHero extends StatelessWidget {
  const _AmountHero({
    required this.controller,
    required this.formatter,
    required this.onAmountChanged,
    this.errorText,
  });

  final TextEditingController controller;
  final CurrencyInputFormatter formatter;
  final ValueChanged<String> onAmountChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();
    final hasError = errorText != null;
    final amountColor = hasError ? colors?.fee : theme.colorScheme.onSurface;
    final zero = const Money(
      minorUnits: 0,
      currency: Currency.mxn,
    ).format(withCode: false);

    return Column(
      children: [
        AppSectionLabel(translations.amountEntry.heroLabel),
        const Gap(AppSpacing.sm),
        TextField(
          controller: controller,
          autofocus: true,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            formatter,
          ],
          onChanged: (text) => onAmountChanged(formatter.cleanMajorFrom(text)),
          cursorColor: theme.colorScheme.primary,
          style: theme.textTheme.displayMedium?.copyWith(
            fontFeatures: tabularFigures,
            color: amountColor,
          ),
          decoration: InputDecoration(
            isCollapsed: true,
            filled: false,
            // Override the global boxed field: the hero amount is bare text.
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            hintText: zero,
            hintStyle: theme.textTheme.displayMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ),
        ),
        if (hasError) ...[
          const Gap(AppSpacing.sm),
          Text(
            errorText!,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: colors?.fee),
          ),
        ],
      ],
    );
  }
}

class _QuoteEmpty extends StatelessWidget {
  const _QuoteEmpty();

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashedBorder(
          color: colors?.border ?? theme.dividerColor,
          radius: AppRadii.card,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              translations.amountEntry.emptyHint,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
