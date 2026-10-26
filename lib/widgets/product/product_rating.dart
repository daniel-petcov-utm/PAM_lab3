import 'package:flutter/material.dart';

class ProductRating extends StatelessWidget {
  final double rating;
  final int ratingCount;

  const ProductRating({
    super.key,
    required this.rating,
    required this.ratingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          final difference = rating - index;
          final icon = difference >= 1
              ? Icons.star
              : difference >= 0.5
              ? Icons.star_half
              : Icons.star_border;

          return Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(icon, color: const Color(0xFF508F80), size: 24),
          );
        }),
        const SizedBox(width: 4),
        Text(
          '($ratingCount)',
          style: const TextStyle(fontSize: 12, color: Color(0xFF666666)),
        ),
      ],
    );
  }
}
