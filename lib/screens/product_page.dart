import 'package:flutter/material.dart';

import '../models/product_details.dart';
import '../services/home_page_service.dart';
import '../widgets/product/product_image_gallery.dart';
import '../widgets/product/product_info_panel.dart';
import '../widgets/product/product_reviews.dart';
import '../widgets/product/product_description.dart';
import '../widgets/product/similar_products.dart';

class ProductPage extends StatefulWidget {
  final String productId;

  const ProductPage({super.key, required this.productId});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final HomePageService _service = HomePageService();

  late Future<ProductDetails?> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = _service.fetchProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCFB),
      body: FutureBuilder<ProductDetails?>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Could not load product.'));
          }

          final product = snapshot.data;

          if (product == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('Product')),
              body: const Center(child: Text('Product not found')),
            );
          }

          return SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProductImageGallery(
                    product: product,
                    onBack: () => Navigator.of(context).maybePop(),
                  ),

                  ProductInfoPanel(product: product),

                  ProductDescription(
                    description: product.description,
                    initiallyExpanded: product.descriptionExpanded,
                  ),

                  ProductReviews(product: product),

                  SimilarProducts(products: product.similarProducts),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
