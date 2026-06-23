import 'package:flutter/material.dart';

/// Flutter equivalent of ui/aspect-ratio.tsx (wraps Radix AspectRatio).
class AppAspectRatio extends StatelessWidget {
  const AppAspectRatio({
    super.key,
    required this.aspectRatio,
    required this.child,
  });

  final double aspectRatio;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: child,
    );
  }
}
