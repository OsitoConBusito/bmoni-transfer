import 'package:bmoni_transfer/core/money/money.dart';
import 'package:bmoni_transfer/shared/utils/money_formatting.dart';
import 'package:flutter/material.dart';

class AppMoneyText extends StatelessWidget {
  const AppMoneyText(this.money, {this.style, this.color, super.key});

  final Money money;
  final TextStyle? style;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final base = style ?? Theme.of(context).textTheme.bodyLarge;
    return Text(money.format(), style: base?.copyWith(color: color));
  }
}
