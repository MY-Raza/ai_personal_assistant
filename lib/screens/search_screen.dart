import 'package:flutter/material.dart';
import '../core/theme/theme.dart';
import '../ui/shared_widgets.dart';

class _SearchResult {
  const _SearchResult({
    required this.title,
    required this.source,
    required this.date,
    required this.desc,
    required this.saved,
  });
  final String title;
  final String source;
  final String date;
  final String desc;
  final bool saved;
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _queryCtrl = TextEditingController();
  bool _searched = false;
  bool _loading = false;

  static const _results = [
    _SearchResult(
      title: 'Understanding Large Language Models: A Complete Guide',
      source: 'arxiv.org',
      date: 'Jun 15, 2026',
      desc: 'A comprehensive overview of how modern LLMs work, their architectures, training methods, and real-world applications.',
      saved: false,
    ),
    _SearchResult(
      title: 'AI Productivity Tools Compared: 2026 Edition',
      source: 'techcrunch.com',
      date: 'Jun 12, 2026',
      desc: 'We tested 12 AI assistants to find which tools actually boost productivity and reduce cognitive load at work.',
      saved: true,
    ),
    _SearchResult(
      title: 'The Future of Personal AI Assistants',
      source: 'wired.com',
      date: 'Jun 10, 2026',
      desc: 'How AI assistants are evolving from simple Q&A bots to proactive life management systems.',
      saved: false,
    ),
    _SearchResult(
      title: 'Prompt Engineering Best Practices for 2026',
      source: 'openai.com',
      date: 'Jun 8, 2026',
      desc: 'Official guide to crafting effective prompts that get the best results from modern AI systems.',
      saved: false,
    ),
  ];

  static const _quickSearches = ['AI productivity tips', 'Best task managers', 'Remote work trends', 'LLM applications'];

  void _handleSearch() {
    if (_queryCtrl.text.trim().isEmpty) return;
    setState(() => _loading = true);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() { _loading = false; _searched = true; });
    });
  }

  @override
  void dispose() {
    _queryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Web Search', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  const Text('AI-powered search & summarization', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xCC1E293B),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                            border: Border.all(color: const Color(0x1AFFFFFF)),
                          ),
                          child: TextField(
                            controller: _queryCtrl,
                            onChanged: (_) => setState(() {}),
                            onSubmitted: (_) => _handleSearch(),
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            decoration: const InputDecoration(
                              hintText: 'Ask AI to search the web...',
                              hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                              prefixIcon: Icon(Icons.search, color: Color(0xFF94A3B8), size: 14),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: _handleSearch,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                            ),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                          ),
                          child: _loading
                              ? const Padding(
                            padding: EdgeInsets.all(14),
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                              : const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                        ),
                      ),
                    ],
                  ),
                  if (!_searched) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _quickSearches.map((s) {
                        return GestureDetector(
                          onTap: () {
                            _queryCtrl.text = s;
                            _handleSearch();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0x661E293B),
                              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                              border: Border.all(color: const Color(0x1AFFFFFF)),
                            ),
                            child: Text(s, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
            Expanded(
              child: !_searched && !_loading
                  ? _buildEmptyState()
                  : _buildResults(),
            ),
          ],
        ),
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
              child: const Icon(Icons.language, color: Color(0x80818CF8), size: 36),
            ),
            const SizedBox(height: 16),
            const Text('Search the web with AI', style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            const Text('Get summaries, key points, and related topics', style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildResults() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      children: [
        GlassCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      ),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: const Icon(Icons.auto_awesome, color: Colors.white, size: 12),
                  ),
                  const SizedBox(width: 8),
                  const Text('AI Summary', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                  const Spacer(),
                  const Text('Based on top results', style: TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Large Language Models have transformed productivity workflows in 2026. Key trends include multimodal AI assistants, proactive task management, and seamless calendar/email integration. The most effective tools combine natural language interfaces with deep system integrations.',
                style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 12, height: 1.6),
              ),
              const SizedBox(height: 12),
              ...[
                'Context-aware responses are 40% more effective',
                'Integration with calendars reduces scheduling time by 60%',
                'AI email drafting saves average 2.5 hours/week',
              ].map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(top: 5),
                      decoration: const BoxDecoration(color: Color(0xFF818CF8), shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(p, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12))),
                  ],
                ),
              )),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Text(
                '4 results for "${_queryCtrl.text.isEmpty ? 'AI productivity' : _queryCtrl.text}"',
                style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
              ),
            ),
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh, color: Color(0xFF818CF8), size: 11),
                SizedBox(width: 4),
                Text('Refresh', style: TextStyle(color: Color(0xFF818CF8), fontSize: 12)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._results.map((r) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlassCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        r.title,
                        style: const TextStyle(color: Color(0xFFA5B4FC), fontSize: 14, fontWeight: FontWeight.w600, height: 1.4),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      r.saved ? Icons.bookmark : Icons.bookmark_border,
                      color: r.saved ? const Color(0xFF818CF8) : const Color(0xFF475569),
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(r.desc, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12, height: 1.6)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0x2614B8A6),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      ),
                      child: Text(r.source, style: const TextStyle(color: Color(0xFF2DD4BF), fontSize: 10, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(width: 8),
                    Text(r.date, style: const TextStyle(color: Color(0xFF64748B), fontSize: 10)),
                    const Spacer(),
                    const Icon(Icons.open_in_new, color: Color(0xFF475569), size: 10),
                  ],
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}