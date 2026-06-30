import 'package:flutter/material.dart';
import '../core/theme/theme.dart';
import '../ui/shared_widgets.dart';

enum _MsgType { text, weather, calendar }

class _Message {
  const _Message({
    required this.id,
    required this.role,
    this.text,
    this.type = _MsgType.text,
    this.tool,
  });
  final int id;
  final String role; // 'user' | 'ai'
  final String? text;
  final _MsgType type;
  final String? tool;
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _inputCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  bool _isTyping = false;

  final List<_Message> _messages = const [
    _Message(
      id: 1,
      role: 'ai',
      text: "Hello Alex! I'm your AI assistant. I can help you manage tasks, schedule events, check weather, search the web, and draft emails. What can I do for you today?",
      type: _MsgType.text,
    ),
    _Message(
      id: 2,
      role: 'user',
      text: "What's the weather like this week and do I have any meetings?",
      type: _MsgType.text,
    ),
    _Message(id: 3, role: 'ai', tool: 'Checking Weather...', type: _MsgType.weather),
    _Message(id: 4, role: 'ai', tool: 'Reading Calendar...', type: _MsgType.calendar),
  ];

  void _sendMessage() {
    final text = _inputCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Message(id: DateTime.now().millisecondsSinceEpoch, role: 'user', text: text));
      _inputCtrl.clear();
      _isTyping = true;
    });
    _scrollToBottom();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add(_Message(
          id: DateTime.now().millisecondsSinceEpoch + 1,
          role: 'ai',
          text: "I've received your message. Let me help you with that right away!",
        ));
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, i) {
                if (i == _messages.length) return _buildTypingIndicator();
                return _buildMessage(_messages[i]);
              },
            ),
          ),
          _buildComposer(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 12, 20, 16),
      decoration: const BoxDecoration(
        color: Color(0xF20F172A),
        border: Border(bottom: BorderSide(color: Color(0x14FFFFFF))),
      ),
      child: Row(
        children: [
          const AiOrb(size: 36),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Assistant', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                Text('● Always here to help', style: TextStyle(color: Color(0xFF2DD4BF), fontSize: 12)),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: const Color(0x1AFFFFFF)),
            ),
            child: const Icon(Icons.more_horiz, color: Color(0xFF94A3B8), size: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(_Message msg) {
    final isUser = msg.role == 'user';
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
              ),
              child: const Icon(Icons.auto_awesome, color: Colors.white, size: 14),
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (msg.tool != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0x1A6366F1),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      border: Border.all(color: const Color(0x336366F1)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(strokeWidth: 1.5, color: Color(0xFFA5B4FC)),
                        ),
                        const SizedBox(width: 8),
                        Text(msg.tool!, style: const TextStyle(color: Color(0xFFA5B4FC), fontSize: 12)),
                      ],
                    ),
                  ),
                if (msg.type == _MsgType.weather) _buildWeatherCard(),
                if (msg.type == _MsgType.calendar) _buildCalendarCard(),
                if (msg.type == _MsgType.text && msg.text != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: isUser
                          ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      )
                          : null,
                      color: isUser ? null : const Color(0xCC1E293B),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: Radius.circular(isUser ? 20 : 4),
                        bottomRight: Radius.circular(isUser ? 4 : 20),
                      ),
                      border: isUser ? null : Border.all(color: const Color(0x1AFFFFFF)),
                    ),
                    child: Text(
                      msg.text!,
                      style: TextStyle(
                        color: isUser ? Colors.white : const Color(0xFFCBD5E1),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard() {
    const days = [
      {'day': 'Mon', 'temp': '72°', 'icon': '☀️'},
      {'day': 'Tue', 'temp': '68°', 'icon': '🌤'},
      {'day': 'Wed', 'temp': '61°', 'icon': '🌧'},
      {'day': 'Thu', 'temp': '65°', 'icon': '⛅'},
    ];
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.wb_sunny_outlined, color: Color(0xFFFBBF24), size: 16),
              SizedBox(width: 8),
              Text('Weather This Week', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: days.map((d) {
              return Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Column(
                    children: [
                      Text(d['day']!, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10)),
                      const SizedBox(height: 4),
                      Text(d['icon']!, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(d['temp']!, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarCard() {
    const events = [
      {'title': 'Design Review', 'time': 'Today 2:00 PM', 'color': 0xFF6366F1},
      {'title': 'Client Call', 'time': 'Today 4:00 PM', 'color': 0xFF14B8A6},
      {'title': 'Team Standup', 'time': 'Tomorrow 9:30 AM', 'color': 0xFF8B5CF6},
    ];
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.calendar_month_outlined, color: Color(0xFF818CF8), size: 16),
              SizedBox(width: 8),
              Text('Upcoming Meetings', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          ...events.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Color(e['color'] as int),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e['title']! as String, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                    Text(e['time']! as String, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10)),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xCC1E293B),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(20),
              ),
              border: Border.all(color: const Color(0x1AFFFFFF)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) => _DotBounce(delay: Duration(milliseconds: i * 150))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComposer() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
      decoration: const BoxDecoration(
        color: Color(0xF20F172A),
        border: Border(top: BorderSide(color: Color(0x14FFFFFF))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xCC1E293B),
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
              border: Border.all(color: const Color(0x1AFFFFFF)),
            ),
            child: const Icon(Icons.attach_file_outlined, color: Color(0xFF94A3B8), size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: 40, maxHeight: 112),
              decoration: BoxDecoration(
                color: const Color(0xCC1E293B),
                borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                border: Border.all(color: const Color(0x1AFFFFFF)),
              ),
              child: TextField(
                controller: _inputCtrl,
                maxLines: null,
                onChanged: (_) => setState(() {}),
                onSubmitted: (_) => _sendMessage(),
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Message AI Assistant...',
                  hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _inputCtrl.text.trim().isNotEmpty ? _sendMessage : null,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: _inputCtrl.text.trim().isNotEmpty
                    ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                )
                    : null,
                color: _inputCtrl.text.trim().isEmpty ? const Color(0xCC1E293B) : null,
                borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                border: _inputCtrl.text.trim().isEmpty
                    ? Border.all(color: const Color(0x1AFFFFFF))
                    : null,
              ),
              child: Icon(
                _inputCtrl.text.trim().isNotEmpty ? Icons.send_rounded : Icons.mic_outlined,
                color: _inputCtrl.text.trim().isNotEmpty ? Colors.white : const Color(0xFF94A3B8),
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DotBounce extends StatefulWidget {
  const _DotBounce({required this.delay});
  final Duration delay;

  @override
  State<_DotBounce> createState() => _DotBounceState();
}

class _DotBounceState extends State<_DotBounce> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );
  late final Animation<double> _anim = Tween(begin: 0.0, end: -6.0).animate(
    CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Transform.translate(
        offset: Offset(0, _anim.value),
        child: Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: const BoxDecoration(
            color: Color(0xFF818CF8),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}