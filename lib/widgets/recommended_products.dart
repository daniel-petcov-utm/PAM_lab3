import 'package:flutter/material.dart';

import '../models/feature_product.dart';
import '../screens/product_page.dart';
import '../services/home_page_service.dart';

class RecommendedProducts extends StatefulWidget {
  const RecommendedProducts({super.key});

  @override
  State<RecommendedProducts> createState() => _RecommendedProductsState();
}

class _RecommendedProductsState extends State<RecommendedProducts> {
  final HomePageService _service = HomePageService();

  late Future<List<FeatureProduct>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _service.fetchRecommendedProducts();
  }

  String _formatPrice(FeatureProduct product) {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section heading.
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Recommended',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Connect to the full product listing later.
                },
                style: TextButton.styleFrom(foregroundColor: Colors.grey),
                child: const Text(
                  'Show all',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // Load product data asynchronously.
          FutureBuilder<List<FeatureProduct>>(
            future: _productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 88,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError) {
                return const SizedBox(
                  height: 88,
                  child: Center(
                    child: Text('Could not load recommended products.'),
                  ),
                );
              }

              final products = snapshot.data ?? [];

              if (products.isEmpty) {
                return const SizedBox(
                  height: 88,
                  child: Center(
                    child: Text('No recommended products available.'),
                  ),
                );
              }

              return SizedBox(
                height: 88,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: products.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 18),
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return _RecommendedProductCard(
                      product: product,
                      formattedPrice: _formatPrice(product),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _RecommendedProductCard extends StatelessWidget {
  final FeatureProduct product;
  final String formattedPrice;

  const _RecommendedProductCard({
    required this.product,
    required this.formattedPrice,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 278,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        child: InkWell(
          borderRadius: BorderRadius.circular(13),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(productId: product.id),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: const Color(0xFFF1F1F1), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 13,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                // Product thumbnail.
                SizedBox(
                  width: 86,
                  height: 88,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const ColoredBox(
                        color: Color(0xFFF0F0F0),
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),

                // Product information.
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF222222),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          formattedPrice,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF222222),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
