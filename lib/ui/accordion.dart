import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

class AppAccordionItemData {
  const AppAccordionItemData({required this.title, required this.content});
  final Widget title;
  final Widget content;
}

/// Flutter equivalent of ui/accordion.tsx
class AppAccordion extends StatefulWidget {
  const AppAccordion({
    super.key,
    required this.items,
    this.allowMultiple = false,
    this.initiallyExpandedIndex,
  });

  final List<AppAccordionItemData> items;
  final bool allowMultiple;
  final int? initiallyExpandedIndex;

  @override
  State<AppAccordion> createState() => _AppAccordionState();
}

class _AppAccordionState extends State<AppAccordion> {
  late Set<int> _expanded = {
    if (widget.initiallyExpandedIndex != null) widget.initiallyExpandedIndex!,
  };

  void _toggle(int index) {
    setState(() {
      if (_expanded.contains(index)) {
        _expanded.remove(index);
      } else {
        if (!widget.allowMultiple) _expanded.clear();
        _expanded.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < widget.items.length; i++)
          _buildItem(context, i, widget.items[i], i != widget.items.length - 1),
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index, AppAccordionItemData item, bool showDivider) {
    final isOpen = _expanded.contains(index);
    return Container(
      decoration: showDivider
          ? const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => _toggle(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.s4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.labelLarge!,
                      child: item.title,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s2),
                  AnimatedRotation(
                    turns: isOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.mutedForeground,
                      size: AppSpacing.iconMd,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: isOpen
                ? Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.s4),
                    child: item.content,
                  )
                : const SizedBox(width: double.infinity, height: 0),
          ),
        ],
      ),
    );
  }
}
