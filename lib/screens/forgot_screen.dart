import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/theme.dart';
import '../ui/shared_widgets.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final _emailCtrl = TextEditingController();
  bool _sent = false;
  bool _loading = false;

  void _reset() {
    setState(() => _loading = true);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() { _loading = false; _sent = true; });
    });
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
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
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
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
                  const Text(
                    'Reset Password',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _sent ? _buildSuccess() : _buildForm(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0x3314B8A6),
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl + 4),
            boxShadow: const [
              BoxShadow(
                color: Color(0x4D14B8A6),
                blurRadius: 40,
              ),
            ],
          ),
          child: const Icon(Icons.check_circle_outline, color: Color(0xFF2DD4BF), size: 40),
        ),
        const SizedBox(height: 24),
        const Text(
          'Check Your Email',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          "We've sent a password reset link to",
          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14, height: 1.6),
          textAlign: TextAlign.center,
        ),
        Text(
          _emailCtrl.text,
          style: const TextStyle(color: Color(0xFFA5B4FC), fontSize: 14, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        GradientButton(
          onPressed: () => context.pop(),
          child: const Text('Back to Sign In'),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0x336366F1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl + 4),
            ),
            child: const Icon(Icons.lock_outline, color: Color(0xFF818CF8), size: 36),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Forgot Password?',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          "Enter your email address and we'll send you a link to reset your password.",
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14, height: 1.6),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        AuthInputField(
          label: 'Email Address',
          hintText: 'your@email.com',
          controller: _emailCtrl,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.mail_outline,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 24),
        GradientButton(
          onPressed: _emailCtrl.text.isNotEmpty ? _reset : null,
          loading: _loading,
          disabled: _emailCtrl.text.isEmpty,
          child: const Text('Send Reset Link'),
        ),
      ],
    );
  }
}