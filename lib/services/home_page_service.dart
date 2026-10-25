import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/hero_banner.dart';
import '../models/feature_product.dart';
import '../models/product_details.dart';
import '../models/new_collection.dart';
import '../models/top_collection.dart';
import '../models/category_promo.dart';
import '../models/product_category.dart';
import '../models/store_title.dart';

class HomePageService {
  Future<HeroBanner> fetchHeroBanner() async {
    final jsonString = await rootBundle.loadString('data/lab-v1.json');

    final Map<String, dynamic> data =
        jsonDecode(jsonString) as Map<String, dynamic>;

    final homePage = data['homePage'] as Map<String, dynamic>;
    final bannerJson = homePage['heroBanner'] as Map<String, dynamic>;

    return HeroBanner.fromJson(bannerJson);
  }

  Future<List<FeatureProduct>> fetchFeatureProducts() async {
    final jsonString = await rootBundle.loadString('data/lab-v1.json');

    final Map<String, dynamic> data =
        jsonDecode(jsonString) as Map<String, dynamic>;

    final homePage = data['homePage'] as Map<String, dynamic>;

    final productsJson = homePage['featureProducts'] as List<dynamic>;

    return productsJson
        .map(
          (product) => FeatureProduct.fromJson(product as Map<String, dynamic>),
        )
        .toList();
  }

  Future<ProductDetails?> fetchProductById(String id) async {
    final jsonString = await rootBundle.loadString('data/lab-v1.json');

    final Map<String, dynamic> data =
        jsonDecode(jsonString) as Map<String, dynamic>;

    final productPage = data['productPage'] as Map<String, dynamic>;

    final products = productPage['products'] as List<dynamic>;

    for (final item in products) {
      final productJson = item as Map<String, dynamic>;

      if (productJson['id'] == id) {
        return ProductDetails.fromJson(productJson);
      }
    }

    return null;
  }

  Future<NewCollection> fetchNewCollection() async {
    final jsonString = await rootBundle.loadString('data/lab-v1.json');

    final Map<String, dynamic> data =
        jsonDecode(jsonString) as Map<String, dynamic>;

    final homePage = data['homePage'] as Map<String, dynamic>;
    final collectionJson = homePage['newCollection'] as Map<String, dynamic>;

    return NewCollection.fromJson(collectionJson);
  }

  Future<List<FeatureProduct>> fetchRecommendedProducts() async {
    final jsonString = await rootBundle.loadString('data/lab-v1.json');

    final Map<String, dynamic> data =
        jsonDecode(jsonString) as Map<String, dynamic>;

    final homePage = data['homePage'] as Map<String, dynamic>;
    final recommendedJson = homePage['recommended'] as List<dynamic>;

    return recommendedJson
        .map((item) => FeatureProduct.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<TopCollection>> fetchTopCollections() async {
    final jsonString = await rootBundle.loadString('data/lab-v1.json');

    final Map<String, dynamic> data =
        jsonDecode(jsonString) as Map<String, dynamic>;

    final homePage = data['homePage'] as Map<String, dynamic>;
    final collectionsJson = homePage['topCollections'] as List<dynamic>;

    return collectionsJson
        .map((item) => TopCollection.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<CategoryPromo>> fetchCategoryPromos() async {
    final jsonString = await rootBundle.loadString('data/lab-v1.json');

    final Map<String, dynamic> data =
        jsonDecode(jsonString) as Map<String, dynamic>;

    final homePage = data['homePage'] as Map<String, dynamic>;
    final promosJson = homePage['categoryPromos'] as List<dynamic>;

    return promosJson
        .map((item) => CategoryPromo.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<ProductCategory>> fetchCategories() async {
    final jsonString = await rootBundle.loadString('data/lab-v1.json');

    final Map<String, dynamic> data =
        jsonDecode(jsonString) as Map<String, dynamic>;

    final homePage = data['homePage'] as Map<String, dynamic>;
    final categoriesJson = homePage['categories'] as List<dynamic>;

    return categoriesJson
        .map((item) => ProductCategory.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<StoreTitle> fetchStoreTitle() async {
    final jsonString = await rootBundle.loadString('data/lab-v1.json');

    final Map<String, dynamic> data =
        jsonDecode(jsonString) as Map<String, dynamic>;

    final homePage = data['homePage'] as Map<String, dynamic>;
    final storeName = homePage['storeName'] as String;

    return StoreTitle(title: storeName);
  }
}
