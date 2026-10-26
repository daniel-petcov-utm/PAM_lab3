import 'similar_product.dart';

class ProductDetails {
  final String id;
  final String name;
  final double price;
  final String currency;
  final String mainImageUrl;
  final List<String> galleryImageUrls;
  final double rating;
  final int ratingCount;
  final int reviewCount;
  final List<ProductColor> availableColors;
  final String selectedColor;
  final List<String> availableSizes;
  final String selectedSize;
  final Map<String, bool> sizeAvailability;
  final bool isFavorite;
  final String description;
  final bool descriptionExpanded;

  final List<RatingBreakdownItem> ratingBreakdown;
  final List<ProductReview> reviews;

  final List<SimilarProduct> similarProducts;

  const ProductDetails({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.mainImageUrl,
    required this.galleryImageUrls,
    required this.rating,
    required this.ratingCount,
    required this.reviewCount,
    required this.availableColors,
    required this.selectedColor,
    required this.availableSizes,
    required this.selectedSize,
    required this.sizeAvailability,
    required this.isFavorite,
    required this.description,
    required this.descriptionExpanded,

    required this.ratingBreakdown,
    required this.reviews,

    required this.similarProducts,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    final actions = json['actions'] as Map<String, dynamic>? ?? {};
    final availability =
        json['sizeAvailability'] as Map<String, dynamic>? ?? {};

    return ProductDetails(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      mainImageUrl: json['mainImageUrl'] as String,
      galleryImageUrls:
          (json['galleryImageUrls'] as List<dynamic>?)?.cast<String>() ??
          [json['mainImageUrl'] as String],
      rating: (json['rating'] as num).toDouble(),
      ratingCount: json['ratingCount'] as int,
      reviewCount: json['reviewCount'] as int,
      availableColors: (json['availableColors'] as List<dynamic>)
          .map((item) => ProductColor.fromJson(item as Map<String, dynamic>))
          .toList(),
      selectedColor: json['selectedColor'] as String,
      availableSizes: (json['availableSizes'] as List<dynamic>).cast<String>(),
      selectedSize: json['selectedSize'] as String,
      sizeAvailability: availability.map(
        (key, value) => MapEntry(key, value as bool),
      ),
      isFavorite: actions['isFavorite'] as bool? ?? false,
      description: json['description'] as String,
      descriptionExpanded: json['descriptionExpanded'] as bool? ?? false,

      ratingBreakdown: (json['ratingBreakdown'] as List<dynamic>)
          .map(
            (item) =>
                RatingBreakdownItem.fromJson(item as Map<String, dynamic>),
          )
          .toList(),

      reviews: (json['reviews'] as List<dynamic>)
          .map((item) => ProductReview.fromJson(item as Map<String, dynamic>))
          .toList(),

      similarProducts: (json['similarProducts'] as List<dynamic>)
          .map((item) => SimilarProduct.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ProductColor {
  final String id;
  final String name;
  final String value;

  const ProductColor({
    required this.id,
    required this.name,
    required this.value,
  });

  factory ProductColor.fromJson(Map<String, dynamic> json) {
    return ProductColor(
      id: json['id'] as String,
      name: json['name'] as String,
      value: json['value'] as String,
    );
  }
}

class RatingBreakdownItem {
  final int stars;
  final int percentage;

  const RatingBreakdownItem({required this.stars, required this.percentage});

  factory RatingBreakdownItem.fromJson(Map<String, dynamic> json) {
    return RatingBreakdownItem(
      stars: json['stars'] as int,
      percentage: json['percentage'] as int,
    );
  }
}

class ProductReview {
  final String id;
  final String author;
  final String avatarUrl;
  final double rating;
  final String createdAtLabel;
  final String text;

  const ProductReview({
    required this.id,
    required this.author,
    required this.avatarUrl,
    required this.rating,
    required this.createdAtLabel,
    required this.text,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      id: json['id'] as String,
      author: json['author'] as String,
      avatarUrl: json['avatarUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      createdAtLabel: json['createdAtLabel'] as String,
      text: json['text'] as String,
    );
  }
}
