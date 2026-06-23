import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

/// Flutter equivalent of ui/pagination.tsx
class AppPagination extends StatelessWidget {
  const AppPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.siblingCount = 1,
  });

  final int currentPage; // 1-based
  final int totalPages;
  final ValueChanged<int> onPageChanged;
  final int siblingCount;

  List<int?> _pageNumbers() {
    // null represents an ellipsis
    final pages = <int?>[];
    final start = (currentPage - siblingCount).clamp(1, totalPages);
    final end = (currentPage + siblingCount).clamp(1, totalPages);

    pages.add(1);
    if (start > 2) pages.add(null);
    for (var p = start; p <= end; p++) {
      if (p != 1 && p != totalPages) pages.add(p);
    }
    if (end < totalPages - 1) pages.add(null);
    if (totalPages > 1) pages.add(totalPages);
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    final pages = _pageNumbers();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _navButton(
          context,
          icon: Icons.chevron_left,
          label: 'Previous',
          onTap: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
        ),
        const SizedBox(width: AppSpacing.s1),
        for (final p in pages) ...[
          if (p == null)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s1),
              child: Icon(Icons.more_horiz, size: AppSpacing.iconSm, color: AppColors.mutedForeground),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _pageButton(context, p),
            ),
        ],
        const SizedBox(width: AppSpacing.s1),
        _navButton(
          context,
          icon: Icons.chevron_right,
          label: 'Next',
          onTap: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
          trailing: true,
        ),
      ],
    );
  }

  Widget _pageButton(BuildContext context, int page) {
    final isActive = page == currentPage;
    return InkWell(
      onTap: () => onPageChanged(page),
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: isActive ? Border.all(color: AppColors.border) : null,
        ),
        child: Text(
          '$page',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: isActive ? AppColors.foreground : AppColors.mutedForeground,
              ),
        ),
      ),
    );
  }

  Widget _navButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    bool trailing = false,
  }) {
    return Opacity(
      opacity: onTap == null ? 0.5 : 1.0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s2, vertical: AppSpacing.s2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!trailing) Icon(icon, size: AppSpacing.iconSm, color: AppColors.foreground),
              Text(label, style: Theme.of(context).textTheme.labelMedium),
              if (trailing) Icon(icon, size: AppSpacing.iconSm, color: AppColors.foreground),
            ],
          ),
        ),
      ),
    );
  }
}
