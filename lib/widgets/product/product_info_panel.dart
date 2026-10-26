import 'package:flutter/material.dart';

import '../../models/product_details.dart';
import 'product_color_selector.dart';
import 'product_rating.dart';
import 'product_size_selector.dart';

class ProductInfoPanel extends StatefulWidget {
  final ProductDetails product;

  const ProductInfoPanel({super.key, required this.product});

  @override
  State<ProductInfoPanel> createState() => _ProductInfoPanelState();
}

class _ProductInfoPanelState extends State<ProductInfoPanel> {
  late String _selectedColor;
  late String _selectedSize;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.product.selectedColor;
    _selectedSize = widget.product.selectedSize;
  }

  String get _formattedPrice {
    final product = widget.product;

    final symbol = switch (product.currency.toUpperCase()) {
      'USD' => r'$',
      'EUR' => '€',
      'GBP' => '£',
      _ => '${product.currency} ',
    };

    return '$symbol${product.price.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Transform.translate(
      offset: const Offset(0, -12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(24, 36, 24, 28),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 14,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name and price.
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF242424),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  _formattedPrice,
                  style: const TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            ProductRating(
              rating: product.rating,
              ratingCount: product.ratingCount,
            ),

            const SizedBox(height: 22),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
            const SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ProductColorSelector(
                    colors: product.availableColors,
                    selectedColor: _selectedColor,
                    onColorSelected: (colorId) {
                      setState(() => _selectedColor = colorId);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ProductSizeSelector(
                    sizes: product.availableSizes,
                    selectedSize: _selectedSize,
                    sizeAvailability: product.sizeAvailability,
                    onSizeSelected: (size) {
                      setState(() => _selectedSize = size);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
