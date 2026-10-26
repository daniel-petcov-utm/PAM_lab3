import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/product_details.dart';
import '../services/home_page_service.dart';

sealed class ProductState {
  const ProductState();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductSuccess extends ProductState {
  final ProductDetails product;

  const ProductSuccess(this.product);
}

class ProductNotFound extends ProductState {
  const ProductNotFound();
}

class ProductError extends ProductState {
  final Object error;

  const ProductError(this.error);
}

class ProductCubit extends Cubit<ProductState> {
  final HomePageService service;

  ProductCubit(this.service) : super(const ProductLoading());

  Future<void> load(String productId) async {
    emit(const ProductLoading());
    try {
      final product = await service.fetchProductById(productId);
      emit(product == null ? const ProductNotFound() : ProductSuccess(product));
    } catch (error) {
      emit(ProductError(error));
    }
  }
}
