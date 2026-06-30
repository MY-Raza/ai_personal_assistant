import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

// ── GlassCard ─────────────────────────────────────────────────────────────────

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0x991E293B),
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: Border.all(color: const Color(0x1AFFFFFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x4D000000),
            blurRadius: 32,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: card);
    }
    return card;
  }
}

// ── GradientButton (PrimaryButton) ───────────────────────────────────────────

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.loading = false,
    this.disabled = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool loading;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final isDisabled = disabled || loading || onPressed == null;
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: GestureDetector(
        onTap: isDisabled ? null : onPressed,
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            boxShadow: const [
              BoxShadow(
                color: Color(0x666366F1),
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: loading
                ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
                : DefaultTextStyle(
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              child: IconTheme(
                data: const IconThemeData(color: Colors.white, size: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [child],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── OutlineButton (SecondaryButton) ──────────────────────────────────────────

class OutlineActionButton extends StatelessWidget {
  const OutlineActionButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          border: Border.all(color: const Color(0x33FFFFFF)),
        ),
        child: Center(
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Color(0xCCFFFFFF),
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
            child: IconTheme(
              data: const IconThemeData(color: Color(0xCCFFFFFF), size: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [child],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── AiOrb ────────────────────────────────────────────────────────────────────

class AiOrb extends StatelessWidget {
  const AiOrb({super.key, this.size = 80, this.animate = false});

  final double size;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final orb = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          center: Alignment(-0.4, -0.4),
          colors: [Color(0xFF818CF8), Color(0xFF6366F1), Color(0xFF4F46E5), Color(0xFF312E81)],
          stops: [0.0, 0.4, 0.7, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.6),
            blurRadius: size * 0.5,
          ),
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.2),
            blurRadius: size,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size * 0.6,
            height: size * 0.6,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: Alignment(-0.2, -0.2),
                colors: [Color(0x4DFFFFFF), Colors.transparent],
              ),
            ),
          ),
          Icon(Icons.auto_awesome, color: Colors.white.withOpacity(0.9), size: size * 0.3),
        ],
      ),
    );

    if (animate) {
      return _PulsingOrb(child: orb);
    }
    return orb;
  }
}

class _PulsingOrb extends StatefulWidget {
  const _PulsingOrb({required this.child});
  final Widget child;

  @override
  State<_PulsingOrb> createState() => _PulsingOrbState();
}

class _PulsingOrbState extends State<_PulsingOrb> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..repeat(reverse: true);

  late final Animation<double> _opacity = Tween<double>(begin: 0.7, end: 1.0).animate(
    CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
  );

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _opacity, child: widget.child);
  }
}

// ── StatusBadge ──────────────────────────────────────────────────────────────

enum StatusColor { indigo, teal, amber, red, purple }

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.label, required this.color});

  final String label;
  final StatusColor color;

  @override
  Widget build(BuildContext context) {
    final bg = _bg();
    final fg = _fg();
    final border = _border();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        border: Border.all(color: border),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: fg),
      ),
    );
  }

  Color _bg() {
    switch (color) {
      case StatusColor.indigo: return const Color(0x336366F1);
      case StatusColor.teal: return const Color(0x3314B8A6);
      case StatusColor.amber: return const Color(0x33F59E0B);
      case StatusColor.red: return const Color(0x33EF4444);
      case StatusColor.purple: return const Color(0x338B5CF6);
    }
  }

  Color _fg() {
    switch (color) {
      case StatusColor.indigo: return const Color(0xFFA5B4FC);
      case StatusColor.teal: return const Color(0xFF5EEAD4);
      case StatusColor.amber: return const Color(0xFFFCD34D);
      case StatusColor.red: return const Color(0xFFFCA5A5);
      case StatusColor.purple: return const Color(0xFFC4B5FD);
    }
  }

  Color _border() {
    switch (color) {
      case StatusColor.indigo: return const Color(0x4D6366F1);
      case StatusColor.teal: return const Color(0x4D14B8A6);
      case StatusColor.amber: return const Color(0x4DF59E0B);
      case StatusColor.red: return const Color(0x4DEF4444);
      case StatusColor.purple: return const Color(0x4D8B5CF6);
    }
  }
}

// ── SocialButton ─────────────────────────────────────────────────────────────

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.icon, required this.label, this.onPressed});

  final String icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0x991E293B),
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            border: Border.all(color: const Color(0x26FFFFFF)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(icon, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xCCFFFFFF),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── AuthInputField ────────────────────────────────────────────────────────────

class AuthInputField extends StatelessWidget {
  const AuthInputField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.onChanged,
  });

  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              color: Color(0xFFCBD5E1),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
        ],
        Container(
          decoration: BoxDecoration(
            color: const Color(0xCC1E293B),
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            border: Border.all(color: const Color(0x1AFFFFFF)),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: const Color(0xFF94A3B8), size: 16)
                  : null,
              suffixIcon: suffixIcon != null
                  ? GestureDetector(
                onTap: onSuffixTap,
                child: Icon(suffixIcon, color: const Color(0xFF94A3B8), size: 16),
              )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: prefixIcon != null ? 0 : 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── IconActionButton ──────────────────────────────────────────────────────────

class IconActionButton extends StatelessWidget {
  const IconActionButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.badge = false,
    this.size = 40,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final bool badge;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: const Color(0xCC1E293B),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: const Color(0x1AFFFFFF)),
            ),
            child: Icon(icon, color: const Color(0xFFCBD5E1), size: 18),
          ),
          if (badge)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF6366F1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}