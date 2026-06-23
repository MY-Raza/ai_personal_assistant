import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

class AppSelectOption<T> {
  const AppSelectOption({required this.value, required this.label, this.icon});
  final T value;
  final String label;
  final Widget? icon;
}

/// Flutter equivalent of ui/select.tsx — a trigger styled like the input
/// field that opens a bottom sheet list of options.
class AppSelect<T> extends StatelessWidget {
  const AppSelect({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.placeholder = 'Select an option',
    this.label,
  });

  final T? value;
  final List<AppSelectOption<T>> options;
  final ValueChanged<T> onChanged;
  final String placeholder;
  final String? label;

  AppSelectOption<T>? get _selected =>
      options.where((o) => o.value == value).cast<AppSelectOption<T>?>().firstOrNull;

  Future<void> _openPicker(BuildContext context) async {
    final selected = await showModalBottomSheet<T>(
      context: context,
      backgroundColor: AppColors.cardSolid,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final option in options)
                ListTile(
                  leading: option.icon,
                  title: Text(option.label),
                  trailing: option.value == value
                      ? const Icon(Icons.check, color: AppColors.primary, size: AppSpacing.iconSm)
                      : null,
                  onTap: () => Navigator.of(context).pop(option.value),
                ),
            ],
          ),
        );
      },
    );
    if (selected != null) onChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selected;
    return InkWell(
      onTap: () => _openPicker(context),
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Container(
        height: AppSpacing.inputHeight,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s3),
        decoration: BoxDecoration(
          color: AppColors.input,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            if (selected?.icon != null) ...[
              selected!.icon!,
              const SizedBox(width: AppSpacing.s2),
            ],
            Expanded(
              child: Text(
                selected?.label ?? label ?? placeholder,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: selected == null
                          ? AppColors.mutedForeground
                          : AppColors.foreground,
                    ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.mutedForeground,
              size: AppSpacing.iconSm,
            ),
          ],
        ),
      ),
    );
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
