import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/product_cubit.dart';
import '../services/home_page_service.dart';
import '../widgets/product/product_image_gallery.dart';
import '../widgets/product/product_info_panel.dart';
import '../widgets/product/product_reviews.dart';
import '../widgets/product/product_description.dart';
import '../widgets/product/similar_products.dart';
import '../widgets/product/add_to_cart_button.dart';

class ProductPage extends StatelessWidget {
  final String productId;

  const ProductPage({super.key, required this.productId});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit(HomePageService())..load(productId),
      child: _ProductView(productId: productId),
    );
  }
}

class _ProductView extends StatelessWidget {
  final String productId;

  const _ProductView({required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is ProductError) {
          return Scaffold(
            body: Center(
              child: FilledButton(
                onPressed: () => context.read<ProductCubit>().load(productId),
                child: const Text('Retry loading product'),
              ),
            ),
          );
        }
        if (state is ProductNotFound) {
          return Scaffold(
            appBar: AppBar(title: const Text('Product')),
            body: const Center(child: Text('Product not found')),
          );
        }
        final product = (state as ProductSuccess).product;
        return Scaffold(
          backgroundColor: const Color(0xFFFFFCFB),
          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x18000000),
                      blurRadius: 16,
                      spreadRadius: 1,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
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
            ),
          ),
          bottomNavigationBar: const AddToCartButton(),
        );
      },
    );
  }
}
