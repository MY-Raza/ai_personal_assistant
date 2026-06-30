import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/theme.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  static const _navItems = [
    _NavItem(icon: Icons.home_rounded, label: 'Home', path: '/dashboard'),
    _NavItem(icon: Icons.chat_bubble_outline_rounded, label: 'Chat', path: '/chat'),
    _NavItem(icon: Icons.check_box_outlined, label: 'Tasks', path: '/tasks'),
    _NavItem(icon: Icons.calendar_month_outlined, label: 'Calendar', path: '/calendar'),
    _NavItem(icon: Icons.person_outline_rounded, label: 'Profile', path: '/profile'),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final idx = _navItems.indexWhere((item) => item.path == location);
    return idx < 0 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: child,
      bottomNavigationBar: _BottomNav(
        currentIndex: currentIndex,
        onTap: (i) => context.go(_navItems[i].path),
        items: _navItems,
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.icon, required this.label, required this.path});
  final IconData icon;
  final String label;
  final String path;
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<_NavItem> items;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xF20F172A),
        border: Border(top: BorderSide(color: Color(0x14FFFFFF))),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottom > 0 ? 0 : 4, top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final item = items[i];
              final isActive = i == currentIndex;
              final isChat = item.path == '/chat';

              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0x266366F1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isChat)
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: isActive
                                ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                            )
                                : null,
                            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                            boxShadow: isActive
                                ? const [
                              BoxShadow(
                                color: Color(0x666366F1),
                                blurRadius: 20,
                                offset: Offset(0, 4),
                              )
                            ]
                                : null,
                          ),
                          child: Icon(
                            item.icon,
                            size: 20,
                            color: isActive ? Colors.white : const Color(0xFF64748B),
                          ),
                        )
                      else
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Icon(
                              item.icon,
                              size: 22,
                              color: isActive ? const Color(0xFF818CF8) : const Color(0xFF64748B),
                            ),
                            if (isActive)
                              Positioned(
                                bottom: -4,
                                child: Container(
                                  width: 16,
                                  height: 2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF6366F1), Color(0xFF14B8A6)],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: isActive ? const Color(0xFF818CF8) : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}