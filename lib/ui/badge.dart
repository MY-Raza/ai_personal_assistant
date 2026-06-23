import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

enum BadgeVariant { default_, secondary, destructive, outline }

/// Flutter equivalent of ui/badge.tsx
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.variant = BadgeVariant.default_,
    this.icon,
  });

  final String label;
  final BadgeVariant variant;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final style = _resolveStyle();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s2, vertical: 2),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: style.border,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(color: style.foreground, size: 12),
              child: icon!,
            ),
            const SizedBox(width: AppSpacing.s1),
          ],
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: style.foreground, letterSpacing: 0),
          ),
        ],
      ),
    );
  }

  _BadgeStyle _resolveStyle() {
    switch (variant) {
      case BadgeVariant.secondary:
        return _BadgeStyle(
          background: AppColors.secondary,
          foreground: AppColors.secondaryForeground,
        );
      case BadgeVariant.destructive:
        return _BadgeStyle(
          background: AppColors.destructive,
          foreground: AppColors.destructiveForeground,
        );
      case BadgeVariant.outline:
        return _BadgeStyle(
          background: Colors.transparent,
          foreground: AppColors.foreground,
          border: Border.all(color: AppColors.border),
        );
      case BadgeVariant.default_:
        return _BadgeStyle(
          background: AppColors.primary,
          foreground: AppColors.primaryForeground,
        );
    }
  }
}

class _BadgeStyle {
  const _BadgeStyle({
    required this.background,
    required this.foreground,
    this.border,
  });
  final Color background;
  final Color foreground;
  final Border? border;
}
