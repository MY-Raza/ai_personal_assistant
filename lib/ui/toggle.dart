import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

enum ToggleVariant { default_, outline }
enum ToggleSize { default_, sm, lg }

/// Flutter equivalent of ui/toggle.tsx
class AppToggle extends StatelessWidget {
  const AppToggle({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.child,
    this.variant = ToggleVariant.default_,
    this.size = ToggleSize.default_,
    this.disabled = false,
  });

  final bool selected;
  final ValueChanged<bool>? onChanged;
  final Widget child;
  final ToggleVariant variant;
  final ToggleSize size;
  final bool disabled;

  double get _height {
    switch (size) {
      case ToggleSize.sm:
        return 32;
      case ToggleSize.lg:
        return 40;
      case ToggleSize.default_:
        return 36;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = disabled || onChanged == null;
    final background = selected ? AppColors.primary.withOpacity(0.15) : Colors.transparent;
    final foreground = selected ? AppColors.foreground : AppColors.mutedForeground;
    final border = variant == ToggleVariant.outline
        ? Border.all(color: AppColors.border)
        : null;

    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: InkWell(
          onTap: isDisabled ? null : () => onChanged!(!selected),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: Container(
            height: _height,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: border,
            ),
            alignment: Alignment.center,
            child: IconTheme(
              data: IconThemeData(color: foreground, size: AppSpacing.iconSm),
              child: DefaultTextStyle(
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: foreground),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
