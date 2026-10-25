import 'package:flutter/material.dart';

import '../models/product_details.dart';
import '../services/home_page_service.dart';

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
      appBar: AppBar(title: const Text('Product')),
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
            return const Center(child: Text('Product not found'));
          }

          return Center(
            child: Text(
              product.name,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
