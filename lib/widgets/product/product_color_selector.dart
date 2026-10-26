import 'package:flutter/material.dart';

import '../../models/product_details.dart';

class ProductColorSelector extends StatelessWidget {
  final List<ProductColor> colors;
  final String selectedColor;
  final ValueChanged<String> onColorSelected;

  const ProductColorSelector({
    super.key,
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
  });

  Color _parseColor(String hex) {
    final normalized = hex.replaceFirst('#', '');
    return Color(int.parse('FF$normalized', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color',
          style: TextStyle(fontSize: 17, color: Color(0xFF798198)),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: colors.map((color) {
            final isSelected = color.id == selectedColor;

            return Tooltip(
              message: color.name,
              child: GestureDetector(
                onTap: () => onColorSelected(color.id),
                child: Container(
                  width: 30,
                  height: 30,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: isSelected
                        ? const [
                            BoxShadow(
                              color: Color(0x22000000),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _parseColor(color.value),
                    ),
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
