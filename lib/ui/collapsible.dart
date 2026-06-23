import 'package:flutter/material.dart';

/// Flutter equivalent of ui/collapsible.tsx
class AppCollapsible extends StatefulWidget {
  const AppCollapsible({
    super.key,
    required this.trigger,
    required this.content,
    this.initiallyExpanded = false,
    this.onChanged,
  });

  final Widget trigger;
  final Widget content;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onChanged;

  @override
  State<AppCollapsible> createState() => AppCollapsibleState();
}

class AppCollapsibleState extends State<AppCollapsible> {
  late bool _expanded = widget.initiallyExpanded;

  void toggle() {
    setState(() => _expanded = !_expanded);
    widget.onChanged?.call(_expanded);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(onTap: toggle, child: widget.trigger),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: _expanded
              ? widget.content
              : const SizedBox(width: double.infinity, height: 0),
        ),
      ],
    );
  }
}
