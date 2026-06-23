import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../core/theme/theme.dart';

/// Flutter equivalent of ui/input-otp.tsx, built on the `pinput` package
/// (already a project dependency) styled to match the design tokens.
class AppInputOtp extends StatelessWidget {
  const AppInputOtp({
    super.key,
    required this.length,
    this.controller,
    this.onChanged,
    this.onCompleted,
    this.errorText,
  });

  final int length;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final String? errorText;

  PinTheme _slotTheme(BuildContext context, {Color? borderColor}) {
    return PinTheme(
      width: 36,
      height: 36,
      textStyle: Theme.of(context).textTheme.bodyLarge,
      decoration: BoxDecoration(
        color: AppColors.input,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: borderColor ?? AppColors.border),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Pinput(
          length: length,
          controller: controller,
          onChanged: onChanged,
          onCompleted: onCompleted,
          defaultPinTheme: _slotTheme(context),
          focusedPinTheme: _slotTheme(context, borderColor: AppColors.ring),
          submittedPinTheme: _slotTheme(context, borderColor: AppColors.primary),
          errorPinTheme: _slotTheme(context, borderColor: AppColors.destructive),
          forceErrorState: errorText != null,
          separatorBuilder: (index) => const SizedBox(width: AppSpacing.s2),
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSpacing.s1),
          Text(
            errorText!,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.destructive),
          ),
        ],
      ],
    );
  }
}
