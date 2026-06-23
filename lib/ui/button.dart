import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

enum ButtonVariant { default_, destructive, outline, secondary, ghost, link }
enum ButtonSize { default_, sm, lg, icon }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = ButtonVariant.default_,
    this.size = ButtonSize.default_,
    this.disabled = false,
    this.loading = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool disabled;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = disabled || loading || onPressed == null;
    final style = _resolveStyle();
    final sizing = _resolveSizing();

    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: Material(
        color: style.background,
        borderRadius: sizing.borderRadius,
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          borderRadius: sizing.borderRadius,
          splashColor: AppColors.white10,
          highlightColor: AppColors.white10,
          child: Container(
            height: sizing.height,
            padding: sizing.padding,
            decoration: BoxDecoration(
              borderRadius: sizing.borderRadius,
              border: style.border,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (loading)
                  SizedBox(
                    width: AppSpacing.iconSm,
                    height: AppSpacing.iconSm,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: style.foreground,
                    ),
                  )
                else
                  DefaultTextStyle(
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: style.foreground,
                    ),
                    child: IconTheme(
                      data: IconThemeData(
                          color: style.foreground, size: AppSpacing.iconMd),
                      child: child,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _ButtonStyle _resolveStyle() {
    switch (variant) {
      case ButtonVariant.default_:
        return _ButtonStyle(
          background: AppColors.primary,
          foreground: AppColors.primaryForeground,
        );
      case ButtonVariant.destructive:
        return _ButtonStyle(
          background: AppColors.destructive,
          foreground: AppColors.destructiveForeground,
        );
      case ButtonVariant.outline:
        return _ButtonStyle(
          background: Colors.transparent,
          foreground: AppColors.foreground,
          border: Border.all(color: AppColors.border),
        );
      case ButtonVariant.secondary:
        return _ButtonStyle(
          background: AppColors.secondary,
          foreground: AppColors.secondaryForeground,
        );
      case ButtonVariant.ghost:
        return _ButtonStyle(
          background: Colors.transparent,
          foreground: AppColors.foreground,
        );
      case ButtonVariant.link:
        return _ButtonStyle(
          background: Colors.transparent,
          foreground: AppColors.primary,
        );
    }
  }

  _ButtonSizing _resolveSizing() {
    switch (size) {
      case ButtonSize.sm:
        return _ButtonSizing(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s3),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        );
      case ButtonSize.lg:
        return _ButtonSizing(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s6),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        );
      case ButtonSize.icon:
        return _ButtonSizing(
          height: 36,
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        );
      case ButtonSize.default_:
        return _ButtonSizing(
          height: AppSpacing.buttonHeight,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        );
    }
  }
}

class _ButtonStyle {
  const _ButtonStyle({
    required this.background,
    required this.foreground,
    this.border,
  });
  final Color background;
  final Color foreground;
  final Border? border;
}

class _ButtonSizing {
  const _ButtonSizing({
    required this.height,
    required this.padding,
    required this.borderRadius,
  });
  final double height;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
}