import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/product_category.dart';
import '../services/home_page_service.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final HomePageService _service = HomePageService();

  late Future<List<ProductCategory>> _categoriesFuture;

  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _service.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductCategory>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const SizedBox(
            height: 100,
            child: Center(child: Text('Could not load categories.')),
          );
        }

        final categories = snapshot.data ?? [];

        if (categories.isEmpty) {
          return const SizedBox.shrink();
        }

        // Initialize selection from the JSON.
        final selectedId =
            _selectedCategoryId ??
            categories
                .where((category) => category.selected)
                .map((category) => category.id)
                .firstOrNull ??
            categories.first.id;

        return SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: categories.map((category) {
              final isSelected = category.id == selectedId;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategoryId = category.id;
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(
                                  color: const Color(0xFF3D2D29),
                                  width: 1.5,
                                )
                              : null,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? const Color(0xFF3D2D29)
                                : const Color(0xFFF2F2F2),
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.network(
                            category.iconUrl,
                            width: 20,
                            height: 20,
                            colorFilter: isSelected
                                ? const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  )
                                : null,
                            placeholderBuilder: (context) => const SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected
                              ? FontWeight.w500
                              : FontWeight.w400,
                          color: isSelected
                              ? const Color(0xFF3D2D29)
                              : const Color(0xFF9B9B9B),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
