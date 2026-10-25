class ProductDetails {
  final String id;
  final String name;

  const ProductDetails({required this.id, required this.name});

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}
