import 'package:flutter/material.dart';

/// Flutter equivalent of ui/tooltip.tsx — thin wrapper over Material
/// Tooltip, styled globally via AppTheme.tooltipTheme.
class AppTooltip extends StatelessWidget {
  const AppTooltip({
    super.key,
    required this.message,
    required this.child,
  });

  final String message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: child,
    );
  }
}
