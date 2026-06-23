import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

/// Flutter equivalent of ui/radio-group.tsx
class AppRadioGroup<T> extends StatelessWidget {
  const AppRadioGroup({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.spacing = AppSpacing.s3,
  });

  final T? value;
  final List<AppRadioItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) SizedBox(height: spacing),
          AppRadioGroupItem<T>(
            value: items[i].value,
            groupValue: value,
            label: items[i].label,
            onChanged: onChanged,
          ),
        ],
      ],
    );
  }
}

class AppRadioItem<T> {
  const AppRadioItem({required this.value, required this.label});
  final T value;
  final Widget label;
}

class AppRadioGroupItem<T> extends StatelessWidget {
  const AppRadioGroupItem({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
  });

  final T value;
  final T? groupValue;
  final Widget label;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged == null ? null : () => onChanged!(value),
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          label,
        ],
      ),
    );
  }
}
