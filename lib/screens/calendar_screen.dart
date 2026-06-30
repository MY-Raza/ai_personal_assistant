import 'package:flutter/material.dart';
import '../core/theme/theme.dart';
import '../ui/shared_widgets.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  String _view = 'month';
  int _selectedDay = 17;

  static const _days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  static const _hasEvent = [3, 7, 11, 14, 17, 19, 22, 25, 28];

  static const _events = [
    _CalEvent(id: 1, title: 'Design Review', time: '2:00 PM', duration: '45m', participants: 4, location: 'Zoom', color: Color(0xFF6366F1)),
    _CalEvent(id: 2, title: 'Client Call — Acme Corp', time: '4:00 PM', duration: '1h', participants: 2, location: 'Phone', color: Color(0xFF14B8A6)),
    _CalEvent(id: 3, title: 'Team Standup', time: '9:30 AM', duration: '30m', participants: 8, location: 'Office', color: Color(0xFF8B5CF6)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Calendar', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                                  Text('June 2026', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
                                ],
                              ),
                            ),
                            ...['month', 'week', 'day'].map((v) {
                              final active = _view == v;
                              return GestureDetector(
                                onTap: () => setState(() => _view = v),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 6),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: active ? const Color(0x4D6366F1) : const Color(0x661E293B),
                                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                  ),
                                  child: Text(
                                    '${v[0].toUpperCase()}${v.substring(1)}',
                                    style: TextStyle(
                                      color: active ? Colors.white : const Color(0xFF94A3B8),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildCalendarGrid(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'June $_selectedDay — ${_events.length} events',
                              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
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
                                Icon(Icons.bolt, color: Color(0xFFA5B4FC), size: 12),
                                SizedBox(width: 4),
                                Text('Find Best Time', style: TextStyle(color: Color(0xFFA5B4FC), fontSize: 12, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ..._events.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildEventCard(e),
                      )),
                      GlassCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: const Color(0x336366F1),
                                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                  ),
                                  child: const Icon(Icons.psychology_outlined, color: Color(0xFF818CF8), size: 14),
                                ),
                                const SizedBox(width: 8),
                                const Text('AI Scheduling Insight', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No conflicts detected for June $_selectedDay. Your optimal focus block is ',
                              style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12, height: 1.6),
                            ),
                            const Text(
                              '10:00 AM – 12:00 PM',
                              style: TextStyle(color: Color(0xFFA5B4FC), fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            const Text(
                              '. Consider scheduling deep work tasks during this window.',
                              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, height: 1.6),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 90,
              right: 24,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                  boxShadow: const [
                    BoxShadow(color: Color(0x806366F1), blurRadius: 32, offset: Offset(0, 8)),
                  ],
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: _days.map((d) => Expanded(
              child: Text(d, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.w600)),
            )).toList(),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: 35,
            itemBuilder: (context, i) {
              // June 2026 starts on Monday (index 1)
              final day = i >= 1 ? i : null;
              if (day == null || day > 30) return const SizedBox.shrink();
              final isSelected = day == _selectedDay;
              final hasEv = _hasEvent.contains(day);
              return GestureDetector(
                onTap: () => setState(() => _selectedDay = day),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    )
                        : null,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        '$day',
                        style: TextStyle(
                          color: isSelected ? Colors.white : const Color(0xFFCBD5E1),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (hasEv && !isSelected)
                        Positioned(
                          bottom: 3,
                          child: Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: Color(0xFF818CF8),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(_CalEvent e) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 48,
            decoration: BoxDecoration(
              color: e.color,
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e.title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 12,
                  children: [
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.access_time, size: 11, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 4),
                      Text('${e.time} · ${e.duration}', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                    ]),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.person_outline, size: 11, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 4),
                      Text('${e.participants}', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                    ]),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.location_on_outlined, size: 11, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 4),
                      Text(e.location, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                    ]),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.more_horiz, color: Color(0xFF64748B), size: 16),
        ],
      ),
    );
  }
}

class _CalEvent {
  const _CalEvent({
    required this.id,
    required this.title,
    required this.time,
    required this.duration,
    required this.participants,
    required this.location,
    required this.color,
  });
  final int id;
  final String title;
  final String time;
  final String duration;
  final int participants;
  final String location;
  final Color color;
}