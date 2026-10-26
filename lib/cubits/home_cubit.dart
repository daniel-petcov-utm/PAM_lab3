import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/home_page_service.dart';

sealed class HomeState {
  const HomeState();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSuccess extends HomeState {
  const HomeSuccess();
}

class HomeEmpty extends HomeState {
  const HomeEmpty();
}

class HomeError extends HomeState {
  final Object error;

  const HomeError(this.error);
}

class HomeCubit extends Cubit<HomeState> {
  final HomePageService service;

  HomeCubit(this.service) : super(const HomeLoading());

  Future<void> load() async {
    emit(const HomeLoading());
    try {
      final featured = await service.fetchFeatureProducts();
      final recommended = await service.fetchRecommendedProducts();
      if (featured.isEmpty && recommended.isEmpty) {
        emit(const HomeEmpty());
      } else {
        emit(const HomeSuccess());
      }
    } catch (error) {
      emit(HomeError(error));
    }
  }
}
