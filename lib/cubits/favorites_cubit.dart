import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<Set<String>> {
  FavoritesCubit([Set<String>? initialFavorites])
    : super(Set.unmodifiable(initialFavorites ?? const {}));

  void toggle(String productId) {
    final next = {...state};
    next.contains(productId) ? next.remove(productId) : next.add(productId);
    emit(Set.unmodifiable(next));
  }

  void initialize(String productId, bool isFavorite) {
    if (isFavorite && !state.contains(productId)) {
      emit(Set.unmodifiable({...state, productId}));
    }
  }
}
