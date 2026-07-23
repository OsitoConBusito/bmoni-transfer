import 'package:bmoni_transfer/features/transfer/domain/entities/fee_breakdown.dart';
import 'package:bmoni_transfer/i18n/strings.g.dart';
import 'package:bmoni_transfer/shared/utils/money_formatting.dart';
import 'package:flutter/material.dart';

// Amounts drop the currency code — the row above already names MXN.
class FeeExplanation extends StatelessWidget {
  const FeeExplanation({required this.breakdown, this.color, super.key});

  final FeeBreakdown breakdown;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final theme = Theme.of(context);
    final text = breakdown.hasVariable
        ? translations.feeInfo.combined(
            fixed: breakdown.fixed.format(withCode: false),
            percent: breakdown.percentLabel,
            variable: breakdown.variable.format(withCode: false),
            threshold: breakdown.threshold.format(withCode: false),
          )
        : translations.feeInfo.fixedOnly(
            fixed: breakdown.fixed.format(withCode: false),
          );
    return Text(
      text,
      style: theme.textTheme.bodySmall?.copyWith(
        color: color ?? theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
