import 'package:flutter/material.dart';
import '../core/theme/theme.dart';
import '../ui/shared_widgets.dart';

class _Memory {
  const _Memory({
    required this.id,
    required this.icon,
    required this.label,
    required this.content,
    required this.active,
  });
  final int id;
  final String icon;
  final String label;
  final String content;
  final bool active;
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _memoryEnabled = true;

  static const _memories = [
    _Memory(id: 1, icon: '💼', label: 'Work', content: 'Senior Product Designer at TechCorp. Prefers Agile workflows. Deep Work hours: 9 AM – 12 PM.', active: true),
    _Memory(id: 2, icon: '📅', label: 'Schedule', content: 'Works Mon–Fri, usually starts at 8:30 AM. Prefers meetings in the afternoon.', active: true),
    _Memory(id: 3, icon: '🎯', label: 'Goals', content: 'Focus: improving productivity and reducing context switching. Learning prompt engineering.', active: true),
    _Memory(id: 4, icon: '🗣️', label: 'Style', content: 'Prefers concise, direct responses. Appreciates bullet points for complex topics.', active: false),
    _Memory(id: 5, icon: '⏰', label: 'Reminders', content: 'Daily standup 9:30 AM. Weekly review every Friday at 4 PM.', active: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildMemoryToggle(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(
                        child: Text('Stored Memories', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0x1A6366F1),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                          border: Border.all(color: const Color(0x4D6366F1)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color: Color(0xFFA5B4FC), size: 12),
                            SizedBox(width: 4),
                            Text('Add', style: TextStyle(color: Color(0xFFA5B4FC), fontSize: 12, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ..._memories.map((m) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildMemoryCard(m),
                  )),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1E1B4B), Color(0xFF0F172A)],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXl + 4),
                  boxShadow: const [
                    BoxShadow(color: Color(0x666366F1), blurRadius: 32, offset: Offset(0, 8)),
                  ],
                ),
                child: const Center(
                  child: Text('AJ', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                ),
              ),
              Positioned(
                bottom: -6,
                right: -6,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFF14B8A6),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    border: Border.all(color: const Color(0xFF0F172A), width: 2),
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Alex Johnson', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
          const Text('alex@example.com', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatusBadge(label: 'Pro Plan', color: StatusColor.indigo),
              SizedBox(width: 8),
              StatusBadge(label: 'Verified', color: StatusColor.teal),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMemoryToggle() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0x336366F1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: const Icon(Icons.psychology_outlined, color: Color(0xFF818CF8), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('AI Memory', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                Text(
                  _memoryEnabled ? 'Active — learning from you' : 'Disabled',
                  style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _memoryEnabled = !_memoryEnabled),
            child: Container(
              width: 48,
              height: 24,
              decoration: BoxDecoration(
                gradient: _memoryEnabled
                    ? const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)])
                    : null,
                color: _memoryEnabled ? null : Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: _memoryEnabled ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: _memoryEnabled ? Colors.white : Colors.white.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemoryCard(_Memory m) {
    return Opacity(
      opacity: m.active ? 1.0 : 0.5,
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(m.icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(m.label, style: const TextStyle(color: Color(0xFFA5B4FC), fontSize: 12, fontWeight: FontWeight.w600)),
                      if (!m.active) ...[
                        const SizedBox(width: 8),
                        const StatusBadge(label: 'Paused', color: StatusColor.amber),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(m.content, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12, height: 1.6)),
                ],
              ),
            ),
            Column(
              children: const [
                Icon(Icons.edit_outlined, color: Color(0xFF64748B), size: 13),
                SizedBox(height: 8),
                Icon(Icons.delete_outline, color: Color(0xFF64748B), size: 13),
              ],
            ),
          ],
        ),
      ),
    );
  }
}