import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

enum AlertVariant { default_, destructive }

/// Flutter equivalent of ui/alert.tsx (Alert, AlertTitle, AlertDescription
/// combined into a single configurable widget).
class AppAlert extends StatelessWidget {
  const AppAlert({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.variant = AlertVariant.default_,
  });

  final String title;
  final String? description;
  final Widget? icon;
  final AlertVariant variant;

  @override
  Widget build(BuildContext context) {
    final accent = variant == AlertVariant.destructive
        ? AppColors.destructive
        : AppColors.foreground;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s4,
        vertical: AppSpacing.s3,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardSolid,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(color: accent, size: AppSpacing.iconMd),
              child: icon!,
            ),
            const SizedBox(width: AppSpacing.s3),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: accent),
                ),
                if (description != null) ...[
                  const SizedBox(height: AppSpacing.s1),
                  Text(
                    description!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: variant == AlertVariant.destructive
                              ? AppColors.destructive.withOpacity(0.9)
                              : AppColors.mutedForeground,
                        ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
