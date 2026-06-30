import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/theme.dart';
import '../ui/shared_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailCtrl = TextEditingController(text: 'alex@example.com');
  final _passCtrl = TextEditingController(text: 'password123');
  bool _showPass = false;
  bool _remember = false;
  bool _loading = false;
  String _error = '';

  void _submit() {
    if (_emailCtrl.text.isEmpty || _passCtrl.text.isEmpty) {
      setState(() => _error = 'Please fill in all fields');
      return;
    }
    setState(() { _error = ''; _loading = true; });
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() => _loading = false);
        context.go('/otp');
      }
    });
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            SizedBox(
              height: 176,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF0F172A), Color(0xFF1E1B4B), Color(0xFF0D1730)],
                        stops: [0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 48,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Color(0xFF0F172A)],
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          AiOrb(size: 60, animate: true),
                          SizedBox(height: 12),
                          Text(
                            'AI Personal Assistant',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Intelligence at your fingertips',
                            style: TextStyle(color: Color(0xFFA5B4FC), fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome Back',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Sign in to continue with your AI assistant',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                  ),
                  const SizedBox(height: 32),

                  if (_error.isNotEmpty) ...[
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0x1AEF4444),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                        border: Border.all(color: const Color(0x4DEF4444)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Color(0xFFFCA5A5), size: 16),
                          const SizedBox(width: 8),
                          Text(_error, style: const TextStyle(color: Color(0xFFFCA5A5), fontSize: 14)),
                        ],
                      ),
                    ),
                  ],

                  AuthInputField(
                    label: 'Email Address',
                    hintText: 'your@email.com',
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.mail_outline,
                  ),
                  const SizedBox(height: 16),
                  AuthInputField(
                    label: 'Password',
                    hintText: 'Your password',
                    controller: _passCtrl,
                    obscureText: !_showPass,
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: _showPass ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    onSuffixTap: () => setState(() => _showPass = !_showPass),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _remember = !_remember),
                        child: Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                gradient: _remember
                                    ? const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                                )
                                    : null,
                                color: _remember ? null : const Color(0xCC1E293B),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: _remember ? const Color(0xFF6366F1) : const Color(0x33FFFFFF),
                                ),
                              ),
                              child: _remember
                                  ? const Icon(Icons.check, color: Colors.white, size: 10)
                                  : null,
                            ),
                            const SizedBox(width: 8),
                            const Text('Remember me', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.push('/forgot'),
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(color: Color(0xFF818CF8), fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  GradientButton(
                    onPressed: _submit,
                    loading: _loading,
                    child: const Text('Sign In'),
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
                        "Don't have an account? ",
                        style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () => context.go('/signup'),
                        child: const Text(
                          'Create Account',
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