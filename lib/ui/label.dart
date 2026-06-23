import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

/// Flutter equivalent of ui/label.tsx
class AppLabel extends StatelessWidget {
  const AppLabel({
    super.key,
    required this.text,
    this.disabled = false,
    this.trailing,
  });

  final String text;
  final bool disabled;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.s2),
            trailing!,
          ],
        ],
      ),
    );
  }
}
