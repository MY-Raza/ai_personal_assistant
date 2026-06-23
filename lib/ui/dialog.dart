import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

/// Flutter equivalent of ui/dialog.tsx.
/// Styling (background, radius, border) comes from AppTheme.dialogTheme;
/// this just provides a convenient show() helper plus header/footer parts.
class AppDialog {
  AppDialog._();

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget title,
    Widget? description,
    required Widget content,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: AppColors.overlay24,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppDialogHeader(title: title, description: description),
                const SizedBox(height: AppSpacing.s4),
                content,
                if (actions != null) ...[
                  const SizedBox(height: AppSpacing.s4),
                  AppDialogFooter(actions: actions),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class AppDialogHeader extends StatelessWidget {
  const AppDialogHeader({super.key, required this.title, this.description});

  final Widget title;
  final Widget? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        DefaultTextStyle(
          style: Theme.of(context).textTheme.titleLarge!,
          child: title,
        ),
        if (description != null) ...[
          const SizedBox(height: AppSpacing.s1),
          DefaultTextStyle(
            style: Theme.of(context).textTheme.bodySmall!,
            child: description!,
          ),
        ],
      ],
    );
  }
}

class AppDialogFooter extends StatelessWidget {
  const AppDialogFooter({super.key, required this.actions});
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (var i = 0; i < actions.length; i++) ...[
          if (i > 0) const SizedBox(width: AppSpacing.s2),
          actions[i],
        ],
      ],
    );
  }
}
