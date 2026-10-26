import 'package:flutter/material.dart';

import '../../models/product_details.dart';

class RatingBreakdown extends StatelessWidget {
  final double rating;
  final int ratingCount;
  final List<RatingBreakdownItem> breakdown;

  const RatingBreakdown({
    super.key,
    required this.rating,
    required this.ratingCount,
    required this.breakdown,
  });

  @override
  Widget build(BuildContext context) {
    final sortedBreakdown = [...breakdown]
      ..sort((a, b) => b.stars.compareTo(a.stars));

    return Column(
      children: [
        Row(
          children: [
            Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Color(0xFF242424),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'OUT OF 5',
              style: TextStyle(fontSize: 10, color: Color(0xFF9B9B9B)),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => const Icon(
                      Icons.star,
                      size: 17,
                      color: Color(0xFF508F80),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '$ratingCount ratings',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFFAAAAAA),
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 24),

        ...sortedBreakdown.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Row(
                    children: [
                      Text(
                        '${item.stars}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9B9B9B),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.star,
                        size: 12,
                        color: Color(0xFF508F80),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: item.percentage.clamp(0, 100) / 100,
                      minHeight: 4,
                      backgroundColor: const Color(0xFFEEEEEE),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF508F80),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 32,
                  child: Text(
                    '${item.percentage}%',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
