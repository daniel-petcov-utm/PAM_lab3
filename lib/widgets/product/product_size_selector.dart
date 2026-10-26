import 'package:flutter/material.dart';

class ProductSizeSelector extends StatelessWidget {
  final List<String> sizes;
  final String selectedSize;
  final Map<String, bool> sizeAvailability;
  final ValueChanged<String> onSizeSelected;

  const ProductSizeSelector({
    super.key,
    required this.sizes,
    required this.selectedSize,
    required this.sizeAvailability,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Size',
          style: TextStyle(fontSize: 17, color: Color(0xFF798198)),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: sizes.map((size) {
            final isSelected = size == selectedSize;
            final isAvailable = sizeAvailability[size] ?? true;

            return GestureDetector(
              onTap: isAvailable ? () => onSizeSelected(size) : null,
              child: Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? const Color(0xFF555555)
                      : const Color(0xFFF7F7F7),
                ),
                child: Text(
                  size,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: !isAvailable
                        ? const Color(0xFFCCCCCC)
                        : isSelected
                        ? Colors.white
                        : const Color(0xFFBDBDBD),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
