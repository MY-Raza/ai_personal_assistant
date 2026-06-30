import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/theme.dart';
import '../ui/shared_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _showPass = false;
  bool _terms = false;
  bool _loading = false;
  final Set<String> _selectedGoals = {};

  static const _goals = ['Productivity', 'Task Management', 'Scheduling', 'Learning', 'Personal Org'];

  int get _strength {
    final len = _passCtrl.text.length;
    if (len == 0) return 0;
    if (len < 6) return 1;
    if (len < 10) return 2;
    return 3;
  }

  static const _strengthColors = ['', '#EF4444', '#F59E0B', '#14B8A6'];
  static const _strengthLabels = ['', 'Weak', 'Fair', 'Strong'];

  Color _strengthColor() => _strength == 0
      ? Colors.transparent
      : Color(int.parse('FF${_strengthColors[_strength].substring(1)}', radix: 16));

  void _submit() {
    setState(() => _loading = true);
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => _loading = false);
        context.go('/otp');
      }
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header banner
            SizedBox(
              height: 144,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF312E81), Color(0xFF1E1B4B)],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -32,
                    right: -32,
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [const Color(0xFF6366F1).withOpacity(0.3), Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          AiOrb(size: 48),
                          SizedBox(height: 8),
                          Text(
                            'AI Personal Assistant',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create Your Account',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Personalize your AI experience',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                  ),
                  const SizedBox(height: 24),

                  AuthInputField(
                    label: 'Full Name',
                    hintText: 'Alex Johnson',
                    controller: _nameCtrl,
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  AuthInputField(
                    label: 'Email Address',
                    hintText: 'alex@example.com',
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.mail_outline,
                  ),
                  const SizedBox(height: 16),

                  // Password with strength
                  AuthInputField(
                    label: 'Password',
                    hintText: 'Create a strong password',
                    controller: _passCtrl,
                    obscureText: !_showPass,
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: _showPass ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    onSuffixTap: () => setState(() => _showPass = !_showPass),
                    onChanged: (_) => setState(() {}),
                  ),
                  if (_passCtrl.text.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ...List.generate(3, (i) {
                          return Expanded(
                            child: Container(
                              height: 4,
                              margin: EdgeInsets.only(right: i < 2 ? 4 : 0),
                              decoration: BoxDecoration(
                                color: i < _strength ? _strengthColor() : Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(width: 8),
                        Text(
                          _strengthLabels[_strength],
                          style: TextStyle(fontSize: 12, color: _strengthColor()),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 16),

                  AuthInputField(
                    label: 'Confirm Password',
                    hintText: 'Repeat password',
                    controller: _confirmCtrl,
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                  ),
                  const SizedBox(height: 16),

                  // Goals
                  const Text(
                    'Main Goals (optional)',
                    style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _goals.map((g) {
                      final selected = _selectedGoals.contains(g);
                      return GestureDetector(
                        onTap: () => setState(() {
                          if (selected) _selectedGoals.remove(g);
                          else _selectedGoals.add(g);
                        }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: selected ? const Color(0x336366F1) : const Color(0x991E293B),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                            border: Border.all(
                              color: selected ? const Color(0x996366F1) : const Color(0x26FFFFFF),
                            ),
                          ),
                          child: Text(
                            g,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: selected ? const Color(0xFFA5B4FC) : const Color(0xFF94A3B8),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Terms
                  GestureDetector(
                    onTap: () => setState(() => _terms = !_terms),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            gradient: _terms
                                ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                            )
                                : null,
                            color: _terms ? null : const Color(0xCC1E293B),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: _terms ? const Color(0xFF6366F1) : const Color(0x33FFFFFF),
                            ),
                          ),
                          child: _terms
                              ? const Icon(Icons.check, color: Colors.white, size: 12)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                              children: [
                                TextSpan(text: 'I agree to the '),
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: TextStyle(color: Color(0xFF818CF8)),
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(color: Color(0xFF818CF8)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  GradientButton(
                    onPressed: _terms ? _submit : null,
                    loading: _loading,
                    disabled: !_terms,
                    child: const Text('Create Account'),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(child: Container(height: 1, color: Colors.white.withOpacity(0.1))),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('or continue with', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                      ),
                      Expanded(child: Container(height: 1, color: Colors.white.withOpacity(0.1))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Row(children: [
                    SocialButton(icon: 'G', label: 'Google'),
                    SizedBox(width: 12),
                    SocialButton(icon: '', label: 'Apple'),
                  ]),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () => context.go('/signin'),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color(0xFF818CF8),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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
}