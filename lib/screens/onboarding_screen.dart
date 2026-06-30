import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/theme.dart';
import '../ui/shared_widgets.dart';

class _OnboardingSlide {
  const _OnboardingSlide({
    required this.title,
    required this.desc,
    required this.icon,
    required this.iconColor,
    required this.gradientColors,
    required this.features,
  });
  final String title;
  final String desc;
  final IconData icon;
  final Color iconColor;
  final List<Color> gradientColors;
  final List<String> features;
}

const _slides = [
  _OnboardingSlide(
    title: 'Your AI Assistant',
    desc: 'Chat with an intelligent assistant that understands your needs and learns from every interaction.',
    icon: Icons.chat_bubble_outline_rounded,
    iconColor: Color(0xFF818CF8),
    gradientColors: [Color(0x336366F1), Color(0x338B5CF6)],
    features: [
      'Natural language understanding',
      'Context-aware responses',
      'Multi-turn conversations',
    ],
  ),
  _OnboardingSlide(
    title: 'Manage Your Life',
    desc: 'Stay on top of tasks, meetings, and reminders with intelligent scheduling and smart suggestions.',
    icon: Icons.check_box_outlined,
    iconColor: Color(0xFF2DD4BF),
    gradientColors: [Color(0x3314B8A6), Color(0x3306B6D4)],
    features: [
      'Smart task management',
      'Calendar scheduling',
      'Personal reminders',
    ],
  ),
  _OnboardingSlide(
    title: 'AI Powered Tools',
    desc: 'Access real-time weather, web search, and email drafting — all through natural conversation.',
    icon: Icons.bolt_rounded,
    iconColor: Color(0xFFFBBF24),
    gradientColors: [Color(0x33F59E0B), Color(0x33F97316)],
    features: [
      'Real-time weather insights',
      'AI web search',
      'Email writing assistant',
    ],
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _slide = 0;

  bool get _isLast => _slide == _slides.length - 1;

  @override
  Widget build(BuildContext context) {
    final slide = _slides[_slide];
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: !_isLast
                    ? GestureDetector(
                  onTap: () => setState(() => _slide = 2),
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                )
                    : const SizedBox.shrink(),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: slide.gradientColors,
                        ),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusXl + 4),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x4D000000),
                            blurRadius: 60,
                            offset: Offset(0, 20),
                          ),
                        ],
                      ),
                      child: Icon(slide.icon, color: slide.iconColor, size: 44),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      slide.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      slide.desc,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 14,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.s8),
                    ...slide.features.map(
                          (f) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Color(0xFF6366F1), Color(0xFF14B8A6)],
                                  ),
                                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                                ),
                                child: const Icon(Icons.check, color: Colors.white, size: 11),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                f,
                                style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                          (i) => GestureDetector(
                        onTap: () => setState(() => _slide = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: i == _slide ? 24 : 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: i == _slide
                                ? const Color(0xFF6366F1)
                                : Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s8),
                  if (_isLast) ...[
                    GradientButton(
                      onPressed: () => context.go('/signup'),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.auto_awesome, size: 16, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Get Started'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlineActionButton(
                      onPressed: () => context.go('/signin'),
                      child: const Text('Sign In'),
                    ),
                  ] else
                    GradientButton(
                      onPressed: () => setState(() => _slide++),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Continue'),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}