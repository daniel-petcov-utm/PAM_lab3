import 'package:flutter/material.dart';

import '../../models/product_details.dart';

class ReviewCard extends StatelessWidget {
  final ProductReview review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 19,
              backgroundColor: const Color(0xFFF0F0F0),
              backgroundImage: NetworkImage(review.avatarUrl),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.author,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF242424),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: List.generate(5, (index) {
                      final difference = review.rating - index;

                      return Icon(
                        difference >= 1
                            ? Icons.star
                            : difference >= 0.5
                            ? Icons.star_half
                            : Icons.star_border,
                        size: 13,
                        color: const Color(0xFF508F80),
                      );
                    }),
                  ),
                ],
              ),
            ),

            Text(
              review.createdAtLabel,
              style: const TextStyle(fontSize: 11, color: Color(0xFFB0B0B0)),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Text(
          review.text,
          style: const TextStyle(
            fontSize: 13,
            height: 1.65,
            fontWeight: FontWeight.w400,
            color: Color(0xFF555555),
          ),
        ),
      ],
    );
  }
}
