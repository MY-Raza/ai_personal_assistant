import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/theme.dart';
import '../ui/shared_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const _tasks = [
    _TaskItem(title: 'Review Q3 proposal', priority: 'high', done: false, time: '2:00 PM'),
    _TaskItem(title: 'Send status update', priority: 'medium', done: true, time: '10:00 AM'),
    _TaskItem(title: 'Team standup notes', priority: 'low', done: false, time: '9:30 AM'),
  ];

  static const _events = [
    _EventItem(title: 'Design Review', time: '2:00 PM', duration: '45m', color: Color(0xFF6366F1)),
    _EventItem(title: 'Client Call', time: '4:00 PM', duration: '1h', color: Color(0xFF14B8A6)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildAiCard(context),
                  const SizedBox(height: 16),
                  _buildQuickActions(context),
                  const SizedBox(height: 16),
                  _buildTasksCard(context),
                  const SizedBox(height: 16),
                  _buildBottomRow(context),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: const Center(
              child: Text('AJ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Good Morning', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                Text('Alex Johnson 👋', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
              ],
            ),
          ),
          Row(
            children: [
              IconActionButton(icon: Icons.notifications_outlined, badge: true),
              const SizedBox(width: 8),
              IconActionButton(
                icon: Icons.settings_outlined,
                onPressed: () => GoRouter.of(context).go('/settings'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAiCard(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      onTap: () => GoRouter.of(context).go('/chat'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AiOrb(size: 40),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AI Assistant', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                    Text('● Online • Ready to help', style: TextStyle(color: Color(0xFF2DD4BF), fontSize: 12)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: const Text('Chat', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0x990F172A),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: const Color(0x14FFFFFF)),
            ),
            child: const Text(
              '💬 "Good morning! How can I help you today? I can manage tasks, schedule events, check weather..."',
              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      _QuickAction(icon: Icons.add, label: 'New Task', path: '/tasks', color: const Color(0xFF6366F1)),
      _QuickAction(icon: Icons.calendar_month_outlined, label: 'Schedule', path: '/calendar', color: const Color(0xFF14B8A6)),
      _QuickAction(icon: Icons.mail_outline, label: 'Draft Email', path: '/email', color: const Color(0xFF8B5CF6)),
      _QuickAction(icon: Icons.language, label: 'Search', path: '/search', color: const Color(0xFFF59E0B)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'QUICK ACTIONS',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.2),
        ),
        const SizedBox(height: 12),
        Row(
          children: actions.map((a) {
            return Expanded(
              child: GestureDetector(
                onTap: () => GoRouter.of(context).go(a.path),
                child: Container(
                  margin: EdgeInsets.only(right: a == actions.last ? 0 : 10),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  decoration: BoxDecoration(
                    color: const Color(0x991E293B),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                    border: Border.all(color: const Color(0x14FFFFFF)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: a.color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                        child: Icon(a.icon, color: a.color, size: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        a.label,
                        style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTasksCard(BuildContext context) {
    const done = 1;
    const total = 3;
    const progress = done / total;
    const angle = 2 * pi * progress;

    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_box_outlined, color: Color(0xFF2DD4BF), size: 16),
              const SizedBox(width: 8),
              const Expanded(
                child: Text("Today's Tasks", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
              ),
              SizedBox(
                width: 32,
                height: 32,
                child: CustomPaint(
                  painter: _CircleProgressPainter(progress: progress),
                  child: const Center(
                    child: Text('67%', style: TextStyle(color: Color(0xFF2DD4BF), fontSize: 9, fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => GoRouter.of(context).go('/tasks'),
                child: const Text('View all', style: TextStyle(color: Color(0xFF818CF8), fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._tasks.map((t) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: t.done ? const Color(0x3314B8A6) : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: t.done ? const Color(0xFF2DD4BF) : const Color(0x33FFFFFF),
                      width: 2,
                    ),
                  ),
                  child: t.done ? const Icon(Icons.check, color: Color(0xFF2DD4BF), size: 9) : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.title,
                        style: TextStyle(
                          color: t.done ? const Color(0xFF64748B) : Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: t.done ? TextDecoration.lineThrough : null,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(t.time, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                    ],
                  ),
                ),
                StatusBadge(
                  label: t.priority,
                  color: t.priority == 'high'
                      ? StatusColor.red
                      : t.priority == 'medium'
                      ? StatusColor.amber
                      : StatusColor.teal,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildBottomRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GlassCard(
            padding: const EdgeInsets.all(16),
            onTap: () => GoRouter.of(context).go('/calendar'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.calendar_month_outlined, color: Color(0xFF818CF8), size: 14),
                    SizedBox(width: 8),
                    Text('Today', style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 12),
                ..._events.map(
                      (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(color: e.color, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.title, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
                            Text('${e.time} · ${e.duration}', style: const TextStyle(color: Color(0xFF64748B), fontSize: 10)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GlassCard(
            padding: const EdgeInsets.all(16),
            onTap: () => GoRouter.of(context).go('/weather'),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.wb_sunny_outlined, color: Color(0xFFFBBF24), size: 14),
                    SizedBox(width: 8),
                    Text('Weather', style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(height: 8),
                Text('72°', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900)),
                Text('Mostly Sunny', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: Color(0xFF64748B), size: 10),
                    SizedBox(width: 2),
                    Text('San Francisco', style: TextStyle(color: Color(0xFF64748B), fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TaskItem {
  const _TaskItem({required this.title, required this.priority, required this.done, required this.time});
  final String title;
  final String priority;
  final bool done;
  final String time;
}

class _EventItem {
  const _EventItem({required this.title, required this.time, required this.duration, required this.color});
  final String title;
  final String time;
  final String duration;
  final Color color;
}

class _QuickAction {
  const _QuickAction({required this.icon, required this.label, required this.path, required this.color});
  final IconData icon;
  final String label;
  final String path;
  final Color color;
}

class _CircleProgressPainter extends CustomPainter {
  const _CircleProgressPainter({required this.progress});
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    canvas.drawCircle(center, radius, Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      Paint()
        ..color = const Color(0xFF14B8A6)
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}