import 'package:flutter/material.dart';

import '../../models/product_details.dart';
import 'rating_breakdown.dart';
import 'review_card.dart';

class ProductReviews extends StatefulWidget {
  final ProductDetails product;

  const ProductReviews({super.key, required this.product});

  @override
  State<ProductReviews> createState() => _ProductReviewsState();
}

class _ProductReviewsState extends State<ProductReviews> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Reviews',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF303030),
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0 : -0.25,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 26,
                      color: Color(0xFF303030),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: _isExpanded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 28),

                      RatingBreakdown(
                        rating: product.rating,
                        ratingCount: product.ratingCount,
                        breakdown: product.ratingBreakdown,
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${product.reviewCount} Reviews',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFFAAAAAA),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              // Add review form navigation later.
                            },
                            iconAlignment: IconAlignment.end,
                            icon: const Icon(Icons.edit, size: 14),
                            label: const Text(
                              'WRITE A REVIEW',
                              style: TextStyle(
                                fontSize: 11,
                                letterSpacing: 0.3,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFFAAAAAA),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      ...product.reviews.map(
                        (review) => Padding(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: ReviewCard(review: review),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
