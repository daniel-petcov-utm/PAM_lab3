class ProductCategory {
  final String id;
  final String name;
  final bool selected;
  final String iconUrl;

  const ProductCategory({
    required this.id,
    required this.name,
    required this.selected,
    required this.iconUrl,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      selected: json['selected'] as bool,
      iconUrl: json['iconUrl'] as String,
    );
  }
}
