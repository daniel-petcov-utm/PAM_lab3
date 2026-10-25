import 'package:flutter/material.dart';

import '../models/feature_product.dart';
import '../services/home_page_service.dart';

import '../screens/product_page.dart';

class FeaturedProducts extends StatefulWidget {
  const FeaturedProducts({super.key});

  @override
  State<FeaturedProducts> createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  final HomePageService _service = HomePageService();

  late Future<List<FeatureProduct>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _service.fetchFeatureProducts();
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
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section heading.
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Feature Products',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Connect to the full product list later.
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                child: const Text(
                  'Show all',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Asynchronously load products.
          FutureBuilder<List<FeatureProduct>>(
            future: _productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 250,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError) {
                return const SizedBox(
                  height: 100,
                  child: Center(
                    child: Text('Could not load featured products.'),
                  ),
                );
              }

              final products = snapshot.data ?? [];

              if (products.isEmpty) {
                return const SizedBox(
                  height: 100,
                  child: Center(child: Text('No featured products available.')),
                );
              }

              return SizedBox(
                height: 310,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: products.length,
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 24),
                  itemBuilder: (context, index) {
                    return _ProductCard(
                      product: products[index],
                      formattedPrice: _formatPrice(products[index]),
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

class _ProductCard extends StatelessWidget {
  final FeatureProduct product;
  final String formattedPrice;

  const _ProductCard({required this.product, required this.formattedPrice});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 165,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(productId: product.id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image.
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: SizedBox(
                width: 165,
                height: 225,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFF0F0F0),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 32,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 17),

            // Product name.
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF222222),
              ),
            ),

            const SizedBox(height: 7),

            // Product price.
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
    );
  }
}
