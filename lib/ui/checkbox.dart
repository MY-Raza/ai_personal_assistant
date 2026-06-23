import 'package:flutter/material.dart';

/// Flutter equivalent of ui/checkbox.tsx — thin wrapper over Material
/// Checkbox, styled globally via AppTheme.checkboxTheme.
class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
    );
  }
}
