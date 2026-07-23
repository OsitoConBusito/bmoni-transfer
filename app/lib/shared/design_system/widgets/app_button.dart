import 'package:bmoni_transfer/shared/design_system/tokens/app_sizing.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// Sizing, radius and text style come from FilledButtonTheme (see AppTheme).
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.loadingLabel,
    this.icon,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final String? loadingLabel;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return FilledButton(
        onPressed: null,
        child: _LoadingContent(label: loadingLabel),
      );
    }
    if (icon == null) {
      return FilledButton(onPressed: onPressed, child: Text(label));
    }
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}

class _LoadingContent extends StatelessWidget {
  const _LoadingContent({this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    final spinner = SizedBox(
      height: AppSizing.spinner,
      width: AppSizing.spinner,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
    if (label == null) return spinner;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        spinner,
        const Gap(AppSpacing.sm),
        Text(label!),
      ],
    );
  }
}
