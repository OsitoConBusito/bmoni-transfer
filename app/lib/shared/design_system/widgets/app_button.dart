import 'package:bmoni_transfer/shared/design_system/tokens/app_radii.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  static const double _height = 52;
  static const double _spinnerSize = 20;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(_height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              height: _spinnerSize,
              width: _spinnerSize,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(label),
    );
  }
}
