import 'package:flutter/material.dart';

/// Flutter equivalent of ui/textarea.tsx
class AppTextarea extends StatelessWidget {
  const AppTextarea({
    super.key,
    this.controller,
    this.hintText,
    this.errorText,
    this.enabled = true,
    this.onChanged,
    this.minLines = 3,
    this.maxLines = 6,
    this.focusNode,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final int minLines;
  final int maxLines;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
      focusNode: focusNode,
      keyboardType: TextInputType.multiline,
      textAlignVertical: TextAlignVertical.top,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
      ),
    );
  }
}
