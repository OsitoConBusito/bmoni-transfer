import 'package:bmoni_transfer/shared/design_system/tokens/app_sizing.dart';
import 'package:bmoni_transfer/shared/design_system/tokens/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// The primary CTA. Sizing, radius and text style come from `FilledButtonTheme`
/// (see `AppTheme`); this widget only adds the in-place loading barrier. When
/// `loadingLabel` is set, the spinner sits beside it (e.g. "Sending…").
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.loadingLabel,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final String? loadingLabel;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading ? _LoadingContent(label: loadingLabel) : Text(label),
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
