import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/theme/theme.dart';
import '../ui/shared_widgets.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final _toCtrl = TextEditingController(text: 'sarah.chen@acme.com');
  final _subjectCtrl = TextEditingController(text: 'Q3 Project Update — Action Items');
  final _bodyCtrl = TextEditingController(
    text: "Hi Sarah,\n\nFollowing up on our discussion from this morning's standup. I wanted to summarize the key action items and next steps for the Q3 project.\n\nThe design review went well, and the team is aligned on the new direction. I'll have the updated mockups ready by Thursday EOD.\n\nLet me know if you need anything else.\n\nBest regards,\nAlex",
  );
  bool _generating = false;
  String? _tone;

  static const _toneOptions = [
    {'label': 'Make Professional', 'key': 'professional', 'icon': Icons.trending_up, 'color': 0xFF6366F1},
    {'label': 'Make Friendly', 'key': 'friendly', 'icon': Icons.star_outline, 'color': 0xFF14B8A6},
    {'label': 'Shorten', 'key': 'short', 'icon': Icons.bolt, 'color': 0xFF8B5CF6},
    {'label': 'Improve Tone', 'key': 'tone', 'icon': Icons.auto_awesome, 'color': 0xFFF59E0B},
  ];

  void _applyTone(String t) {
    setState(() { _tone = t; _generating = true; });
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      setState(() {
        _generating = false;
        if (t == 'professional') {
          _bodyCtrl.text = "Dear Sarah,\n\nI am writing to follow up on the action items discussed during this morning's project standup. The design review was productive, and all stakeholders are aligned on the strategic direction.\n\nI will deliver the updated mockups by Thursday, end of business.\n\nPlease do not hesitate to reach out should you require any additional information.\n\nKind regards,\nAlex Johnson";
        } else if (t == 'friendly') {
          _bodyCtrl.text = "Hey Sarah! 👋\n\nJust wanted to follow up on our chat this morning - the standup was super productive! Great news: everyone's on the same page with the new direction 🎉\n\nI'll have those updated mockups ready for you by Thursday. Can't wait to show you what we came up with!\n\nCatch you later,\nAlex";
        } else if (t == 'short') {
          _bodyCtrl.text = "Hi Sarah,\n\nQ3 project update: design review complete, team aligned. Mockups ready Thursday EOD.\n\nAlex";
        }
      });
    });
  }

  @override
  void dispose() {
    _toCtrl.dispose();
    _subjectCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email Assistant', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                  SizedBox(height: 4),
                  Text('AI-powered email drafting', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                children: [
                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AuthInputField(label: 'To', hintText: 'recipient@email.com', controller: _toCtrl, prefixIcon: Icons.person_outline),
                        const SizedBox(height: 12),
                        AuthInputField(label: 'Subject', hintText: 'Email subject', controller: _subjectCtrl, prefixIcon: Icons.edit_outlined),
                        const SizedBox(height: 12),
                        const Text('Message', style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 14, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 6),
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xCC1E293B),
                                borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                                border: Border.all(color: const Color(0x1AFFFFFF)),
                              ),
                              child: TextField(
                                controller: _bodyCtrl,
                                maxLines: 8,
                                style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 14, height: 1.6),
                                decoration: const InputDecoration(
                                  hintText: 'Write your email or let AI generate it for you...',
                                  hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(16),
                                ),
                              ),
                            ),
                            if (_generating)
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                    child: Container(
                                      color: const Color(0xB30F172A),
                                      child: Center(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: const Color(0x336366F1),
                                            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                          ),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.auto_awesome, color: Color(0xFF818CF8), size: 14),
                                              SizedBox(width: 8),
                                              Text('Rewriting email...', style: TextStyle(color: Color(0xFFA5B4FC), fontSize: 12, fontWeight: FontWeight.w500)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'AI CONTROLS',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 2.6,
                    children: _toneOptions.map((btn) {
                      final isActive = _tone == btn['key'];
                      final color = Color(btn['color'] as int);
                      return GestureDetector(
                        onTap: () => _applyTone(btn['key'] as String),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isActive ? color.withOpacity(0.15) : const Color(0x991E293B),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                            border: Border.all(
                              color: isActive ? Colors.white.withOpacity(0.2) : const Color(0x1AFFFFFF),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(btn['icon'] as IconData, size: 13, color: isActive ? color : const Color(0xFF94A3B8)),
                              const SizedBox(width: 8),
                              Text(
                                btn['label'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isActive ? color : const Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(children: [
                          Icon(Icons.mail_outline, color: Color(0xFF2DD4BF), size: 14),
                          SizedBox(width: 8),
                          Text('Preview', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                        ]),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0x800F172A),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                            border: Border.all(color: const Color(0x14FFFFFF)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(TextSpan(
                                children: [
                                  const TextSpan(text: 'To: ', style: TextStyle(color: Color(0xFF64748B))),
                                  TextSpan(text: _toCtrl.text, style: const TextStyle(color: Color(0xFF94A3B8))),
                                ],
                              ), style: const TextStyle(fontSize: 12)),
                              const SizedBox(height: 4),
                              Text.rich(TextSpan(
                                children: [
                                  const TextSpan(text: 'Subject: ', style: TextStyle(color: Color(0xFF64748B))),
                                  TextSpan(text: _subjectCtrl.text, style: const TextStyle(color: Color(0xFF94A3B8))),
                                ],
                              ), style: const TextStyle(fontSize: 12)),
                              const SizedBox(height: 8),
                              Text(
                                _bodyCtrl.text,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 12, height: 1.6),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(child: _buildActionButton(Icons.copy_outlined, 'Copy', false)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildActionButton(Icons.edit_outlined, 'Edit', false)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildActionButton(Icons.send_rounded, 'Send', true)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, bool primary) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        gradient: primary
            ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
        )
            : null,
        color: primary ? null : const Color(0x991E293B),
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: primary ? null : Border.all(color: const Color(0x26FFFFFF)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 15, color: primary ? Colors.white : const Color(0xFFCBD5E1)),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: primary ? Colors.white : const Color(0xFFCBD5E1),
            ),
          ),
        ],
      ),
    );
  }
}