import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

/// Flutter equivalent of ui/avatar.tsx (Avatar, AvatarImage, AvatarFallback
/// combined into a single configurable widget).
class AppAvatar extends StatefulWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.fallback,
    this.size = 40,
  });

  final String? imageUrl;
  final Widget? fallback;
  final double size;

  @override
  State<AppAvatar> createState() => _AppAvatarState();
}

class _AppAvatarState extends State<AppAvatar> {
  bool _didError = false;

  @override
  Widget build(BuildContext context) {
    final showFallback = widget.imageUrl == null || widget.imageUrl!.isEmpty || _didError;

    return ClipOval(
      child: Container(
        width: widget.size,
        height: widget.size,
        color: AppColors.muted,
        child: showFallback
            ? Center(child: widget.fallback ?? const SizedBox.shrink())
            : Image.network(
                widget.imageUrl!,
                width: widget.size,
                height: widget.size,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) setState(() => _didError = true);
                  });
                  return Center(child: widget.fallback ?? const SizedBox.shrink());
                },
              ),
      ),
    );
  }
}
