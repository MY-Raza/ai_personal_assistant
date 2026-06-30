import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/theme.dart';

enum _NotifType { task, calendar, weather, email, search, system }

class _NotificationItem {
  const _NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.time,
    required this.read,
  });
  final int id;
  final _NotifType type;
  final String title;
  final String message;
  final String time;
  final bool read;
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<_NotificationItem> _notifications = [
    const _NotificationItem(
      id: 1,
      type: _NotifType.task,
      title: 'Task Reminder',
      message: '"Review Q3 marketing proposal" is due today at 2:00 PM.',
      time: '5m ago',
      read: false,
    ),
    const _NotificationItem(
      id: 2,
      type: _NotifType.calendar,
      title: 'Upcoming Meeting',
      message: 'Design Review starts in 30 minutes with 4 participants.',
      time: '32m ago',
      read: false,
    ),
    const _NotificationItem(
      id: 3,
      type: _NotifType.system,
      title: 'AI Assistant',
      message: 'I\'ve organized your tasks by priority for tomorrow.',
      time: '1h ago',
      read: false,
    ),
    const _NotificationItem(
      id: 4,
      type: _NotifType.weather,
      title: 'Weather Alert',
      message: 'Rain expected Wednesday. Consider rescheduling outdoor plans.',
      time: '3h ago',
      read: true,
    ),
    const _NotificationItem(
      id: 5,
      type: _NotifType.email,
      title: 'Email Drafted',
      message: 'Your email to Sarah Chen is ready for review.',
      time: '5h ago',
      read: true,
    ),
    const _NotificationItem(
      id: 6,
      type: _NotifType.search,
      title: 'Search Complete',
      message: 'Found 4 new results for "AI productivity tools".',
      time: 'Yesterday',
      read: true,
    ),
    const _NotificationItem(
      id: 7,
      type: _NotifType.task,
      title: 'Task Completed',
      message: 'Great job! You completed "Morning workout routine".',
      time: 'Yesterday',
      read: true,
    ),
  ];

  int get _unreadCount => _notifications.where((n) => !n.read).length;

  void _markAllRead() {
    setState(() {
      for (var i = 0; i < _notifications.length; i++) {
        final n = _notifications[i];
        if (!n.read) {
          _notifications[i] = _NotificationItem(
            id: n.id,
            type: n.type,
            title: n.title,
            message: n.message,
            time: n.time,
            read: true,
          );
        }
      }
    });
  }

  void _markOneRead(int id) {
    setState(() {
      final i = _notifications.indexWhere((n) => n.id == id);
      if (i != -1 && !_notifications[i].read) {
        final n = _notifications[i];
        _notifications[i] = _NotificationItem(
          id: n.id,
          type: n.type,
          title: n.title,
          message: n.message,
          time: n.time,
          read: true,
        );
      }
    });
  }

  void _dismiss(int id) {
    setState(() => _notifications.removeWhere((n) => n.id == id));
  }

  ({IconData icon, Color color}) _iconFor(_NotifType type) {
    switch (type) {
      case _NotifType.task:
        return (icon: Icons.check_box_outlined, color: const Color(0xFF2DD4BF));
      case _NotifType.calendar:
        return (icon: Icons.calendar_month_outlined, color: const Color(0xFF818CF8));
      case _NotifType.weather:
        return (icon: Icons.wb_sunny_outlined, color: const Color(0xFFFBBF24));
      case _NotifType.email:
        return (icon: Icons.mail_outline, color: const Color(0xFFC4B5FD));
      case _NotifType.search:
        return (icon: Icons.language, color: const Color(0xFFF59E0B));
      case _NotifType.system:
        return (icon: Icons.auto_awesome, color: const Color(0xFF818CF8));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _notifications.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                itemCount: _notifications.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildNotificationCard(_notifications[i]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0x991E293B),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(color: const Color(0x1AFFFFFF)),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text(
                  _unreadCount > 0 ? '$_unreadCount unread' : 'All caught up',
                  style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                ),
              ],
            ),
          ),
          if (_unreadCount > 0)
            GestureDetector(
              onTap: _markAllRead,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0x1A6366F1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  border: Border.all(color: const Color(0x4D6366F1)),
                ),
                child: const Text(
                  'Mark all read',
                  style: TextStyle(color: Color(0xFFA5B4FC), fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0x1A6366F1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusXl + 4),
              ),
              child: const Icon(Icons.notifications_none_rounded, color: Color(0x80818CF8), size: 36),
            ),
            const SizedBox(height: 16),
            const Text(
              'No notifications',
              style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            const Text(
              "You're all caught up for now",
              style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(_NotificationItem n) {
    final meta = _iconFor(n.type);
    return Dismissible(
      key: ValueKey(n.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _dismiss(n.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0x33EF4444),
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        ),
        child: const Icon(Icons.delete_outline, color: Color(0xFFFCA5A5), size: 20),
      ),
      child: GestureDetector(
        onTap: () => _markOneRead(n.id),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: n.read ? const Color(0x991E293B) : const Color(0xCC1E293B),
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            border: Border.all(
              color: n.read ? const Color(0x1AFFFFFF) : const Color(0x406366F1),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: meta.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Icon(meta.icon, color: meta.color, size: 17),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            n.title,
                            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        if (!n.read)
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(left: 8, top: 4),
                            decoration: const BoxDecoration(
                              color: Color(0xFF6366F1),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      n.message,
                      style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12, height: 1.5),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      n.time,
                      style: const TextStyle(color: Color(0xFF64748B), fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}