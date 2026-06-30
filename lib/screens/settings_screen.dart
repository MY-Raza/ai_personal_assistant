import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/theme.dart';
import '../ui/shared_widgets.dart';

class _SettingItem {
  const _SettingItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.hasArrow = false,
    this.toggleValue,
    this.onToggle,
    this.badge,
    this.value,
  });
  final IconData icon;
  final Color iconColor;
  final String label;
  final bool hasArrow;
  final bool? toggleValue;
  final VoidCallback? onToggle;
  final String? badge;
  final String? value;
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _darkMode = true;
  bool _memory = true;

  List<MapEntry<String, List<_SettingItem>>> get _sections => [
    MapEntry('Account', [
      const _SettingItem(icon: Icons.person_outline, iconColor: Color(0xFF818CF8), label: 'Profile Settings', hasArrow: true),
      const _SettingItem(icon: Icons.shield_outlined, iconColor: Color(0xFF2DD4BF), label: 'Security & Privacy', hasArrow: true),
      const _SettingItem(icon: Icons.lock_outline, iconColor: Color(0xFFC4B5FD), label: 'Two-Factor Auth', hasArrow: true),
    ]),
    MapEntry('AI Preferences', [
      const _SettingItem(icon: Icons.psychology_outlined, iconColor: Color(0xFF818CF8), label: 'AI Personality', hasArrow: true),
      const _SettingItem(icon: Icons.volume_up_outlined, iconColor: Color(0xFF2DD4BF), label: 'Response Style', hasArrow: true),
      _SettingItem(
        icon: Icons.auto_awesome,
        iconColor: const Color(0xFFFBBF24),
        label: 'Memory Settings',
        toggleValue: _memory,
        onToggle: () => setState(() => _memory = !_memory),
      ),
    ]),
    MapEntry('Connected Tools', [
      const _SettingItem(icon: Icons.calendar_month_outlined, iconColor: Color(0xFF818CF8), label: 'Calendar Integration', badge: 'Connected'),
      const _SettingItem(icon: Icons.cloud_outlined, iconColor: Color(0xFF2DD4BF), label: 'Weather API', badge: 'Connected'),
      const _SettingItem(icon: Icons.mail_outline, iconColor: Color(0xFFC4B5FD), label: 'Email Integration', badge: 'Connect'),
      const _SettingItem(icon: Icons.language, iconColor: Color(0xFFFBBF24), label: 'Web Search', badge: 'Connected'),
    ]),
    MapEntry('Preferences', [
      _SettingItem(
        icon: Icons.notifications_outlined,
        iconColor: const Color(0xFF818CF8),
        label: 'Notifications',
        toggleValue: _notifications,
        onToggle: () => setState(() => _notifications = !_notifications),
      ),
      _SettingItem(
        icon: Icons.dark_mode_outlined,
        iconColor: const Color(0xFFC4B5FD),
        label: 'Dark Mode',
        toggleValue: _darkMode,
        onToggle: () => setState(() => _darkMode = !_darkMode),
      ),
      const _SettingItem(icon: Icons.language, iconColor: Color(0xFF2DD4BF), label: 'Language', value: 'English'),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          children: [
            const Text('Settings', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('Customize your AI experience', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
            const SizedBox(height: 20),
            ..._sections.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 10),
                    child: Text(
                      entry.key.toUpperCase(),
                      style: const TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.2),
                    ),
                  ),
                  GlassCard(
                    child: Column(
                      children: List.generate(entry.value.length, (i) {
                        final item = entry.value[i];
                        final isLast = i == entry.value.length - 1;
                        return Container(
                          decoration: BoxDecoration(
                            border: isLast
                                ? null
                                : const Border(bottom: BorderSide(color: Color(0x0FFFFFFF))),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                ),
                                child: Icon(item.icon, color: item.iconColor, size: 16),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(item.label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                              ),
                              if (item.toggleValue != null)
                                GestureDetector(
                                  onTap: item.onToggle,
                                  child: Container(
                                    width: 40,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      gradient: item.toggleValue!
                                          ? const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)])
                                          : null,
                                      color: item.toggleValue! ? null : Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                                    ),
                                    child: AnimatedAlign(
                                      duration: const Duration(milliseconds: 200),
                                      alignment: item.toggleValue! ? Alignment.centerRight : Alignment.centerLeft,
                                      child: Container(
                                        width: 18,
                                        height: 18,
                                        margin: const EdgeInsets.symmetric(horizontal: 2),
                                        decoration: BoxDecoration(
                                          color: item.toggleValue! ? Colors.white : Colors.white.withOpacity(0.4),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              else if (item.badge != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: item.badge == 'Connected' ? const Color(0x2614B8A6) : const Color(0x266366F1),
                                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                                  ),
                                  child: Text(
                                    item.badge!,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: item.badge == 'Connected' ? const Color(0xFF5EEAD4) : const Color(0xFFA5B4FC),
                                    ),
                                  ),
                                )
                              else if (item.value != null)
                                  Text(item.value!, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12))
                                else if (item.hasArrow)
                                    const Icon(Icons.chevron_right, color: Color(0xFF64748B), size: 16),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            )),

            GestureDetector(
              onTap: () => context.go('/signin'),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                  border: Border.all(color: const Color(0x33EF4444)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Color(0xFFF87171), size: 16),
                    SizedBox(width: 8),
                    Text('Sign Out', style: TextStyle(color: Color(0xFFF87171), fontSize: 14, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'AI Personal Assistant v2.1.0\n© 2026 AI Labs Inc.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF475569), fontSize: 11, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}