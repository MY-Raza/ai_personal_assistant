import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

/// Flutter equivalent of ui/progress.tsx
/// [value] is 0-100 to match the original (shadcn) API.
class AppProgress extends StatelessWidget {
  const AppProgress({
    super.key,
    required this.value,
    this.height = 8,
  });

  final double value; // 0-100
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      child: SizedBox(
        height: height,
        child: LinearProgressIndicator(
          value: (value.clamp(0, 100)) / 100,
          backgroundColor: AppColors.primary.withOpacity(0.2),
          color: AppColors.primary,
        ),
      ),
    );
  }
}
