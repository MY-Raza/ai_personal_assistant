import 'package:flutter/material.dart';

/// Flutter equivalent of ui/switch.tsx — thin wrapper over Material Switch,
/// styled globally via AppTheme.switchTheme.
class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
    );
  }
}
