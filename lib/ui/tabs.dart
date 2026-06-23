import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

class AppTabItem {
  const AppTabItem({required this.label, required this.content});
  final Widget label;
  final Widget content;
}

/// Flutter equivalent of ui/tabs.tsx
class AppTabs extends StatefulWidget {
  const AppTabs({
    super.key,
    required this.items,
    this.initialIndex = 0,
    this.onChanged,
  });

  final List<AppTabItem> items;
  final int initialIndex;
  final ValueChanged<int>? onChanged;

  @override
  State<AppTabs> createState() => _AppTabsState();
}

class _AppTabsState extends State<AppTabs> {
  late int _index = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.muted,
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          ),
          child: Row(
            children: [
              for (var i = 0; i < widget.items.length; i++)
                Expanded(child: _buildTab(context, i)),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s2),
        widget.items[_index].content,
      ],
    );
  }

  Widget _buildTab(BuildContext context, int i) {
    final selected = i == _index;
    return GestureDetector(
      onTap: () {
        setState(() => _index = i);
        widget.onChanged?.call(i);
      },
      child: Container(
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.cardSolid : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: selected ? AppColors.foreground : AppColors.mutedForeground,
              ),
          child: widget.items[i].label,
        ),
      ),
    );
  }
}
