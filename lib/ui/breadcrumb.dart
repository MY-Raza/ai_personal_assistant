import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

class AppBreadcrumbItem {
  const AppBreadcrumbItem({required this.label, this.onTap});
  final String label;
  final VoidCallback? onTap;
}

/// Flutter equivalent of ui/breadcrumb.tsx
class AppBreadcrumb extends StatelessWidget {
  const AppBreadcrumb({super.key, required this.items});

  final List<AppBreadcrumbItem> items;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s1),
              child: Icon(
                Icons.chevron_right,
                size: 14,
                color: AppColors.mutedForeground,
              ),
            ),
          ],
          _buildItem(context, items[i], isLast: i == items.length - 1),
        ],
      ],
    );
  }

  Widget _buildItem(BuildContext context, AppBreadcrumbItem item, {required bool isLast}) {
    final style = Theme.of(context).textTheme.bodyMedium;
    if (isLast || item.onTap == null) {
      return Text(
        item.label,
        style: style?.copyWith(
          color: isLast ? AppColors.foreground : AppColors.mutedForeground,
        ),
      );
    }
    return InkWell(
      onTap: item.onTap,
      child: Text(
        item.label,
        style: style?.copyWith(color: AppColors.mutedForeground),
      ),
    );
  }
}
