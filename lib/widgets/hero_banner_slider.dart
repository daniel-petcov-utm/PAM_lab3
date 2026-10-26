import 'package:flutter/material.dart';

import '../models/hero_banner.dart';
import '../services/home_page_service.dart';

class HeroBannerSlider extends StatefulWidget {
  const HeroBannerSlider({super.key});

  @override
  State<HeroBannerSlider> createState() => _HeroBannerSliderState();
}

class _HeroBannerSliderState extends State<HeroBannerSlider> {
  final HomePageService _service = HomePageService();

  late Future<HeroBanner> _bannerFuture;

  @override
  void initState() {
    super.initState();
    _bannerFuture = _service.fetchHeroBanner();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HeroBanner>(
      future: _bannerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 220,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const SizedBox(
            height: 220,
            child: Center(child: Text('Could not load the banner.')),
          );
        }

        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        return _buildBanner(snapshot.data!);
      },
    );
  }

  Widget _buildBanner(HeroBanner banner) {
    final slideCount = banner.slides > 0 ? banner.slides : 1;
    final activeIndex = banner.activeSlide.clamp(0, slideCount - 1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AspectRatio(
        aspectRatio: 1.78,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Banner image.
              Image.network(
                banner.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE7D6C5),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      size: 40,
                    ),
                  );
                },
              ),

              // Subtle overlay improves white text readability.
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.transparent,
                      Color(0x1A000000),
                      Color(0x33000000),
                    ],
                  ),
                ),
              ),

              // Banner title.
              Positioned(
                right: 14,
                top: 0,
                bottom: 25,
                width: MediaQuery.of(context).size.width * 0.38,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    banner.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      height: 1.45,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              // Pagination indicators.
              Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(slideCount, (index) {
                    final isActive = index == activeIndex;

                    return Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: isActive
                            ? Border.all(color: Colors.white, width: 1.5)
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: isActive ? 3 : 6,
                        height: isActive ? 3 : 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(
                            alpha: isActive ? 1.0 : 0.85,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
