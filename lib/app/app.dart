import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

// TODO: Replace with go_router config once screen files are uploaded.
// Placeholder keeps the project compilable at every conversion step.

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Personal Assistant App',
      debugShowCheckedModeBanner: false,

      // Dark theme is the primary theme for this project.
      // Light theme is wired in but currently mirrors dark until a palette is designed.
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,

      // Placeholder home — will be replaced by go_router's RouterConfig
      // once navigation and screen files are uploaded.
      home: const _Placeholder(),
    );
  }
}

// ── Placeholder ───────────────────────────────────────────────────────────────

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assistant_rounded,
              size: 64,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: AppSpacing.s4),
            Text(
              'AI Personal Assistant',
              style: theme.textTheme.displayLarge,
            ),
            const SizedBox(height: AppSpacing.s2),
            Text(
              'Awaiting screen files…',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}