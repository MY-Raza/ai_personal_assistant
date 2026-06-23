import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

/// Flutter equivalent of ui/dropdown-menu.tsx, built on Material
/// PopupMenuButton (styled globally via AppTheme.popupMenuTheme).
abstract class AppDropdownEntry<T> {
  const AppDropdownEntry();
}

class AppDropdownItem<T> extends AppDropdownEntry<T> {
  const AppDropdownItem({
    required this.value,
    required this.label,
    this.icon,
    this.shortcut,
    this.destructive = false,
    this.enabled = true,
  });

  final T value;
  final String label;
  final Widget? icon;
  final String? shortcut;
  final bool destructive;
  final bool enabled;
}

class AppDropdownLabel<T> extends AppDropdownEntry<T> {
  const AppDropdownLabel(this.text);
  final String text;
}

class AppDropdownSeparator<T> extends AppDropdownEntry<T> {
  const AppDropdownSeparator();
}

class AppDropdownMenu<T> extends StatelessWidget {
  const AppDropdownMenu({
    super.key,
    required this.trigger,
    required this.entries,
    required this.onSelected,
  });

  final Widget trigger;
  final List<AppDropdownEntry<T>> entries;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      onSelected: onSelected,
      color: AppColors.popover,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        side: const BorderSide(color: AppColors.border),
      ),
      itemBuilder: (context) {
        final items = <PopupMenuEntry<T>>[];
        for (final entry in entries) {
          if (entry is AppDropdownLabel<T>) {
            items.add(PopupMenuItem<T>(
              enabled: false,
              height: 32,
              child: Text(
                entry.text,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ));
          } else if (entry is AppDropdownSeparator<T>) {
            items.add(const PopupMenuDivider());
          } else if (entry is AppDropdownItem<T>) {
            final color = entry.destructive
                ? AppColors.destructive
                : AppColors.foreground;
            items.add(PopupMenuItem<T>(
              value: entry.value,
              enabled: entry.enabled,
              child: Row(
                children: [
                  if (entry.icon != null) ...[
                    IconTheme(
                      data: IconThemeData(color: color, size: AppSpacing.iconSm),
                      child: entry.icon!,
                    ),
                    const SizedBox(width: AppSpacing.s2),
                  ],
                  Expanded(
                    child: Text(
                      entry.label,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: color),
                    ),
                  ),
                  if (entry.shortcut != null) ...[
                    const SizedBox(width: AppSpacing.s2),
                    Text(
                      entry.shortcut!,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.mutedForeground),
                    ),
                  ],
                ],
              ),
            ));
          }
        }
        return items;
      },
      child: trigger,
    );
  }
}
