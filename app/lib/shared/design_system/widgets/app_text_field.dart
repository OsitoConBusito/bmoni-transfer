import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.label,
    required this.onChanged,
    this.hint,
    this.errorText,
    this.keyboardType,
    super.key,
  });

  final String label;
  final ValueChanged<String> onChanged;
  final String? hint;
  final String? errorText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
      ),
    );
  }
}
