import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

/// Flutter equivalent of ui/drawer.tsx (vaul Drawer) — implemented as a
/// modal bottom sheet, styled via AppTheme.bottomSheetTheme (drag handle
/// included automatically).
class AppDrawer {
  AppDrawer._();

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget Function(BuildContext context) builder,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: AppColors.cardSolid,
      builder: builder,
    );
  }
}

class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({super.key, required this.title, this.description});

  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          if (description != null) ...[
            const SizedBox(height: AppSpacing.s1),
            Text(description!, style: Theme.of(context).textTheme.bodySmall),
          ],
        ],
      ),
    );
  }
}

class AppDrawerFooter extends StatelessWidget {
  const AppDrawerFooter({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(height: AppSpacing.s2),
            children[i],
          ],
        ],
      ),
    );
  }
}
