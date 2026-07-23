import 'package:bmoni_transfer/core/money/money.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_fonts.dart';
import 'package:bmoni_transfer/shared/theme/app_typography.dart';
import 'package:bmoni_transfer/shared/utils/money_formatting.dart';
import 'package:flutter/material.dart';

/// Renders a `Money` in the display face with tabular figures, so amounts stay
/// column-aligned as digits change. The caller sets size via `style`; the font
/// family and tabular feature are enforced here — money never drifts to prose.
class AppMoneyText extends StatelessWidget {
  const AppMoneyText(
    this.money, {
    this.style,
    this.color,
    this.negative = false,
    super.key,
  });

  final Money money;
  final TextStyle? style;
  final Color? color;

  /// Prepends a minus sign — used for the fee, which is deducted from the send.
  final bool negative;

  @override
  Widget build(BuildContext context) {
    final base = style ?? Theme.of(context).textTheme.titleMedium;
    final text = negative ? '−${money.format()}' : money.format();
    return Text(
      text,
      style: base?.copyWith(
        fontFamily: AppFonts.display,
        fontFeatures: tabularFigures,
        color: color,
      ),
    );
  }
}
