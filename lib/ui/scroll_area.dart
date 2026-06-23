import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

/// Flutter equivalent of ui/scroll-area.tsx — a scrollable area with a
/// visible thin scrollbar, matching the Radix ScrollArea look.
class AppScrollArea extends StatelessWidget {
  const AppScrollArea({
    super.key,
    required this.child,
    this.scrollDirection = Axis.vertical,
    this.controller,
  });

  final Widget child;
  final Axis scrollDirection;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final effectiveController = controller ?? ScrollController();
    return Scrollbar(
      controller: effectiveController,
      thumbVisibility: false,
      radius: const Radius.circular(AppSpacing.radiusFull),
      child: SingleChildScrollView(
        controller: effectiveController,
        scrollDirection: scrollDirection,
        child: child,
      ),
    );
  }
}
