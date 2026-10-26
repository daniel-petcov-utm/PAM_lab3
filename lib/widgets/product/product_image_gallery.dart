import 'package:flutter/material.dart';

import '../../models/product_details.dart';
import 'circle_action_button.dart';

class ProductImageGallery extends StatefulWidget {
  final ProductDetails product;
  final VoidCallback onBack;

  const ProductImageGallery({
    super.key,
    required this.product,
    required this.onBack,
  });

  @override
  State<ProductImageGallery> createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  late final PageController _pageController;
  late bool _isFavorite;
  int _activeImageIndex = 0;

  List<String> get _images {
    final images = widget.product.galleryImageUrls;
    return images.isEmpty ? [widget.product.mainImageUrl] : images;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _isFavorite = widget.product.isFavorite;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.57,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            onPageChanged: (index) {
              setState(() => _activeImageIndex = index);
            },
            itemBuilder: (context, index) {
              return Image.network(
                _images[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const ColoredBox(
                    color: Color(0xFFF5F0ED),
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              );
            },
          ),

          Positioned(
            left: 24,
            top: 24,
            child: CircleActionButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: widget.onBack,
            ),
          ),

          Positioned(
            right: 24,
            top: 24,
            child: CircleActionButton(
              icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
              iconColor: _isFavorite
                  ? const Color(0xFFFF696D)
                  : const Color(0xFF303030),
              onTap: () {
                setState(() => _isFavorite = !_isFavorite);
              },
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_images.length, (index) {
                final isActive = index == _activeImageIndex;

                return Container(
                  width: 13,
                  height: 13,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive ? Colors.white : const Color(0xFF555555),
                    border: isActive
                        ? Border.all(color: const Color(0xFF555555), width: 1.5)
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: isActive
                      ? Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF555555),
                          ),
                        )
                      : null,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
