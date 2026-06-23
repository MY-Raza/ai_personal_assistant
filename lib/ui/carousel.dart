import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../core/theme/theme.dart';

/// Flutter equivalent of ui/carousel.tsx (Embla), built on the
/// `carousel_slider` package (already a project dependency).
class AppCarousel extends StatefulWidget {
  const AppCarousel({
    super.key,
    required this.items,
    this.height = 220,
    this.showArrows = true,
    this.showDots = true,
    this.autoPlay = false,
    this.viewportFraction = 0.92,
  });

  final List<Widget> items;
  final double height;
  final bool showArrows;
  final bool showDots;
  final bool autoPlay;
  final double viewportFraction;

  @override
  State<AppCarousel> createState() => _AppCarouselState();
}

class _AppCarouselState extends State<AppCarousel> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider(
              carouselController: _controller,
              items: widget.items,
              options: CarouselOptions(
                height: widget.height,
                viewportFraction: widget.viewportFraction,
                enlargeCenterPage: true,
                autoPlay: widget.autoPlay,
                onPageChanged: (index, _) => setState(() => _current = index),
              ),
            ),
            if (widget.showArrows) ...[
              Positioned(
                left: AppSpacing.s1,
                child: _arrowButton(
                  icon: Icons.arrow_back,
                  onTap: () => _controller.previousPage(),
                ),
              ),
              Positioned(
                right: AppSpacing.s1,
                child: _arrowButton(
                  icon: Icons.arrow_forward,
                  onTap: () => _controller.nextPage(),
                ),
              ),
            ],
          ],
        ),
        if (widget.showDots) ...[
          const SizedBox(height: AppSpacing.s3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < widget.items.length; i++)
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == _current
                        ? AppColors.primary
                        : AppColors.border,
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _arrowButton({required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: AppColors.cardSolid.withOpacity(0.9),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s2),
          child: Icon(icon, size: AppSpacing.iconSm, color: AppColors.foreground),
        ),
      ),
    );
  }
}
