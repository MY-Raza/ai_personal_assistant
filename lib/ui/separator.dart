import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

/// Flutter equivalent of ui/separator.tsx
class AppSeparator extends StatelessWidget {
  const AppSeparator({
    super.key,
    this.orientation = Axis.horizontal,
    this.thickness = 1,
  });

  final Axis orientation;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    if (orientation == Axis.vertical) {
      return VerticalDivider(
        width: thickness,
        thickness: thickness,
        color: AppColors.border,
      );
    }
    return Divider(
      height: thickness,
      thickness: thickness,
      color: AppColors.border,
    );
  }
}
