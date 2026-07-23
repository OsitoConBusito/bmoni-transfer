import 'package:flutter/material.dart';

/// The small uppercase, wide-tracked label the design uses above hero content
/// (e.g. "TÚ ENVÍAS · MXN"). Reads the muted label style from the theme.
class AppSectionLabel extends StatelessWidget {
  const AppSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      textAlign: TextAlign.center,
      style: theme.textTheme.labelMedium?.copyWith(
        letterSpacing: 1,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
