import 'package:bmoni_transfer/features/transfer/domain/entities/fee_breakdown.dart';
import 'package:bmoni_transfer/i18n/strings.g.dart';
import 'package:bmoni_transfer/shared/utils/money_formatting.dart';
import 'package:flutter/material.dart';

/// One muted caption explaining how the fee was composed, straight from the
/// backend breakdown: a flat fee, or flat + percent once the amount crosses the
/// threshold. Amounts drop the currency code — the row above already names MXN.
class FeeExplanation extends StatelessWidget {
  const FeeExplanation({required this.breakdown, super.key});

  final FeeBreakdown breakdown;

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
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
