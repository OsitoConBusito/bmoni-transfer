import 'package:bmoni_transfer/core/error/failure.dart';
import 'package:bmoni_transfer/features/transfer/domain/entities/transfer.dart';
import 'package:bmoni_transfer/features/transfer/presentation/utils/failure_message.dart';
import 'package:bmoni_transfer/i18n/strings.g.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_spacing.dart';
import 'package:bmoni_transfer/shared/design_system/widgets/app_button.dart';
import 'package:bmoni_transfer/shared/theme/app_colors.dart';
import 'package:bmoni_transfer/shared/utils/money_formatting.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ResultPage extends StatelessWidget {
  const ResultPage.success(Transfer transfer, {super.key})
    : _transfer = transfer,
      _failure = null;

  const ResultPage.failure(Failure failure, {super.key})
    : _failure = failure,
      _transfer = null;

  final Transfer? _transfer;
  final Failure? _failure;

  void _backToStart(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();
    final transfer = _transfer;
    final isSuccess = transfer != null;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(
                isSuccess ? Icons.check_circle_outline : Icons.error_outline,
                size: 72,
                color: isSuccess
                    ? (colors?.positive ?? theme.colorScheme.primary)
                    : theme.colorScheme.error,
              ),
              const Gap(AppSpacing.lg),
              Text(
                isSuccess
                    ? translations.result.successTitle
                    : translations.result.failureTitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall,
              ),
              const Gap(AppSpacing.sm),
              Text(
                isSuccess
                    ? translations.result.successBody(
                        amount: transfer.destAmount.format(),
                      )
                    : failureMessage(translations, _failure!),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              if (!isSuccess) ...[
                AppButton(
                  label: translations.result.retryCta,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Gap(AppSpacing.sm),
              ],
              AppButton(
                label: translations.result.doneCta,
                onPressed: () => _backToStart(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
