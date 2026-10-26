import 'package:flutter/material.dart';

import '../../models/similar_product.dart';

class SimilarProductCard extends StatelessWidget {
  final SimilarProduct product;
  final VoidCallback onTap;

  const SimilarProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  String get _formattedPrice {
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
    return SizedBox(
      width: 122,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 122,
                height: 167,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const ColoredBox(
                      color: Color(0xFFF0F0F0),
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF292929),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              _formattedPrice,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF222222),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
