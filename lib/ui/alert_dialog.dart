import 'package:flutter/material.dart';
import '../core/theme/theme.dart';
import 'button.dart';

/// Flutter equivalent of ui/alert-dialog.tsx — a confirmation dialog with
/// a Cancel (outline) and Action (default) button, built on AppButton.
class AppAlertDialog {
  AppAlertDialog._();

  static Future<bool> show({
    required BuildContext context,
    required String title,
    String? description,
    String actionLabel = 'Continue',
    String cancelLabel = 'Cancel',
    bool destructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierColor: AppColors.overlay24,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                if (description != null) ...[
                  const SizedBox(height: AppSpacing.s2),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
                const SizedBox(height: AppSpacing.s6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppButton(
                      variant: ButtonVariant.outline,
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(cancelLabel),
                    ),
                    const SizedBox(width: AppSpacing.s2),
                    AppButton(
                      variant: destructive
                          ? ButtonVariant.destructive
                          : ButtonVariant.default_,
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(actionLabel),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    return result ?? false;
  }
}
