import 'package:flutter/material.dart';
import '../core/theme/theme.dart';
import '../ui/shared_widgets.dart';

class _Task {
  _Task({
    required this.id,
    required this.title,
    required this.category,
    required this.priority,
    required this.done,
    required this.due,
    required this.starred,
  });
  final int id;
  final String title;
  final String category;
  final String priority;
  bool done;
  final String due;
  final bool starred;
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<_Task> _tasks = [
    _Task(id: 1, title: 'Review Q3 marketing proposal', category: 'Work', priority: 'high', done: false, due: 'Today', starred: true),
    _Task(id: 2, title: 'Prepare presentation slides', category: 'Work', priority: 'high', done: false, due: 'Tomorrow', starred: false),
    _Task(id: 3, title: 'Morning workout routine', category: 'Personal', priority: 'medium', done: true, due: 'Today', starred: false),
    _Task(id: 4, title: 'Read 30 pages of Deep Work', category: 'Personal', priority: 'low', done: false, due: 'Today', starred: false),
    _Task(id: 5, title: 'Send weekly team updates', category: 'Work', priority: 'medium', done: false, due: 'Fri', starred: true),
    _Task(id: 6, title: 'Dentist appointment', category: 'Personal', priority: 'high', done: false, due: 'Thu', starred: false),
  ];

  String _filter = 'All';
  final _searchCtrl = TextEditingController();

  static const _filters = ['All', 'Work', 'Personal', 'Important'];

  List<_Task> get _filtered {
    return _tasks.where((t) {
      if (_filter == 'Work') return t.category == 'Work';
      if (_filter == 'Personal') return t.category == 'Personal';
      if (_filter == 'Important') return t.priority == 'high';
      return true;
    }).where((t) => t.title.toLowerCase().contains(_searchCtrl.text.toLowerCase())).toList();
  }

  int get _doneCount => _tasks.where((t) => t.done).length;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
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
                              child: Text(
                                'My Tasks',
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0x991E293B),
                                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                border: Border.all(color: const Color(0x1AFFFFFF)),
                              ),
                              child: const Icon(Icons.filter_list, color: Color(0xFF94A3B8), size: 15),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0x991E293B),
                                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                border: Border.all(color: const Color(0x1AFFFFFF)),
                              ),
                              child: const Icon(Icons.sort, color: Color(0xFF94A3B8), size: 15),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$_doneCount of ${_tasks.length} completed',
                          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                          child: SizedBox(
                            height: 6,
                            child: LinearProgressIndicator(
                              value: _doneCount / _tasks.length,
                              backgroundColor: Colors.white.withOpacity(0.1),
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Search
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xCC1E293B),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                            border: Border.all(color: const Color(0x1AFFFFFF)),
                          ),
                          child: TextField(
                            controller: _searchCtrl,
                            onChanged: (_) => setState(() {}),
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            decoration: const InputDecoration(
                              hintText: 'Search tasks...',
                              hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                              prefixIcon: Icon(Icons.search, color: Color(0xFF94A3B8), size: 14),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Filter chips
                        SizedBox(
                          height: 36,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: _filters.map((f) {
                              final active = _filter == f;
                              return GestureDetector(
                                onTap: () => setState(() => _filter = f),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: active ? const Color(0x406366F1) : const Color(0x661E293B),
                                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                    border: Border.all(
                                      color: active ? const Color(0x666366F1) : const Color(0x1AFFFFFF),
                                    ),
                                  ),
                                  child: Text(
                                    f,
                                    style: TextStyle(
                                      color: active ? Colors.white : const Color(0xFF94A3B8),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildTaskCard(filtered[i]),
                      ),
                      childCount: filtered.length,
                    ),
                  ),
                ),
              ],
            ),

            // FAB
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
                    BoxShadow(
                      color: Color(0x806366F1),
                      blurRadius: 32,
                      offset: Offset(0, 8),
                    ),
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

  Widget _buildTaskCard(_Task t) {
    return Opacity(
      opacity: t.done ? 0.6 : 1.0,
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => setState(() => t.done = !t.done),
              child: Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: t.done ? const Color(0x3314B8A6) : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: t.done ? const Color(0xFF2DD4BF) : const Color(0x40FFFFFF),
                    width: 2,
                  ),
                ),
                child: t.done ? const Icon(Icons.check, color: Color(0xFF2DD4BF), size: 11) : null,
              ),
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
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      StatusBadge(label: t.category, color: StatusColor.indigo),
                      StatusBadge(
                        label: t.priority,
                        color: t.priority == 'high'
                            ? StatusColor.red
                            : t.priority == 'medium'
                            ? StatusColor.amber
                            : StatusColor.teal,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.access_time, size: 10, color: Color(0xFF64748B)),
                          const SizedBox(width: 4),
                          Text(t.due, style: const TextStyle(color: Color(0xFF64748B), fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.star_rounded,
              size: 16,
              color: t.starred ? const Color(0xFFFBBF24) : const Color(0xFF334155),
            ),
          ],
        ),
      ),
    );
  }
}