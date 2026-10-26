import 'package:flutter_test/flutter_test.dart';
import 'package:lab_3/cubits/favorites_cubit.dart';
import 'package:lab_3/models/product_details.dart';

void main() {
  test('favorites cubit keeps one shared toggle state per product', () {
    final cubit = FavoritesCubit({'p003'});

    cubit.toggle('p001');
    expect(cubit.state, containsAll(<String>['p003', 'p001']));

    cubit.toggle('p003');
    expect(cubit.state, isNot(contains('p003')));
    expect(cubit.state, contains('p001'));
  });

  test(
    'product parser supplies safe defaults for optional detail sections',
    () {
      final product = ProductDetails.fromJson({
        'id': 'p001',
        'name': 'Turtleneck Sweater',
        'price': 39.99,
        'currency': 'USD',
        'mainImageUrl': 'https://example.com/product.jpg',
      });

      expect(product.galleryImageUrls, ['https://example.com/product.jpg']);
      expect(product.availableSizes, isEmpty);
      expect(product.similarProducts, isEmpty);
    },
  );
}
