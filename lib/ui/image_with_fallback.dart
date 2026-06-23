import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/theme/theme.dart';

/// Flutter equivalent of ImageWithFallback.tsx
/// Shows a broken-image SVG placeholder when the network image fails to load.
class ImageWithFallback extends StatefulWidget {
  const ImageWithFallback({
    super.key,
    required this.src,
    this.alt,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  final String src;
  final String? alt;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  @override
  State<ImageWithFallback> createState() => _ImageWithFallbackState();
}

class _ImageWithFallbackState extends State<ImageWithFallback> {
  bool _didError = false;

  @override
  Widget build(BuildContext context) {
    final content = _didError ? _buildFallback(context) : _buildImage();

    if (widget.borderRadius != null) {
      return ClipRRect(
        borderRadius: widget.borderRadius!,
        child: content,
      );
    }
    return content;
  }

  Widget _buildImage() {
    return Image.network(
      widget.src,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      semanticLabel: widget.alt,
      errorBuilder: (_, __, ___) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) setState(() => _didError = true);
        });
        return _buildFallback(context);
      },
    );
  }

  Widget _buildFallback(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: AppColors.muted.withOpacity(0.3),
      child: Center(
        child: SvgPicture.string(
          _kBrokenImageSvg,
          width: 44,
          height: 44,
        ),
      ),
    );
  }
}

// Inline SVG matching the base64 source in the original TSX
const String _kBrokenImageSvg = '''
<svg width="88" height="88" xmlns="http://www.w3.org/2000/svg"
     stroke="#000" stroke-linejoin="round" opacity=".3"
     fill="none" stroke-width="3.7">
  <rect x="16" y="16" width="56" height="56" rx="6"/>
  <path d="m16 58 16-18 32 32"/>
  <circle cx="53" cy="35" r="7"/>
</svg>
''';