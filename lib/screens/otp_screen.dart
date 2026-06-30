import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/theme.dart';
import '../ui/shared_widgets.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  int _timer = 59;
  bool _loading = false;
  Timer? _countdown;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _countdown = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) { t.cancel(); return; }
      setState(() {
        if (_timer > 0) _timer--;
        else t.cancel();
      });
    });
  }

  bool get _filled => _controllers.every((c) => c.text.isNotEmpty);

  void _onChanged(int i, String v) {
    if (v.isEmpty) {
      if (i > 0) _focusNodes[i - 1].requestFocus();
    } else if (v.length == 1) {
      if (i < 5) _focusNodes[i + 1].requestFocus();
    }
    setState(() {});
  }

  void _verify() {
    setState(() => _loading = true);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() => _loading = false);
        context.go('/dashboard');
      }
    });
  }

  @override
  void dispose() {
    _countdown?.cancel();
    for (final c in _controllers) c.dispose();
    for (final n in _focusNodes) n.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0x336366F1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusXl + 4),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x4D6366F1),
                        blurRadius: 40,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.smartphone_outlined, color: Color(0xFF818CF8), size: 36),
                ),
                const SizedBox(height: AppSpacing.s8),
                const Text(
                  'Verify Your Email',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text(
                  'We sent a 6-digit code to',
                  style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14, height: 1.6),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'alex@example.com',
                  style: TextStyle(color: Color(0xFFA5B4FC), fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: AppSpacing.s8),

                // OTP boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (i) {
                    final filled = _controllers[i].text.isNotEmpty;
                    return Container(
                      width: 48,
                      height: 56,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xCC1E293B),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                        border: Border.all(
                          color: filled ? const Color(0x996366F1) : const Color(0x1AFFFFFF),
                          width: filled ? 2 : 1,
                        ),
                      ),
                      child: TextField(
                        controller: _controllers[i],
                        focusNode: _focusNodes[i],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        onChanged: (v) => _onChanged(i, v),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: AppSpacing.s8),

                GradientButton(
                  onPressed: _filled ? _verify : null,
                  loading: _loading,
                  disabled: !_filled,
                  child: const Text('Verify Code'),
                ),
                const SizedBox(height: 24),

                if (_timer > 0)
                  Text(
                    'Resend code in 0:${_timer.toString().padLeft(2, '0')}',
                    style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                  )
                else
                  GestureDetector(
                    onTap: () => setState(() {
                      _timer = 59;
                      _startTimer();
                    }),
                    child: const Text(
                      'Resend Code',
                      style: TextStyle(
                        color: Color(0xFF818CF8),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                const Text(
                  'Change email address',
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}