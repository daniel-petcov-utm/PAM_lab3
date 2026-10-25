class CategoryPromo {
  final String id;
  final String category;
  final String title;
  final String imageUrl;

  const CategoryPromo({
    required this.id,
    required this.category,
    required this.title,
    required this.imageUrl,
  });

  factory CategoryPromo.fromJson(Map<String, dynamic> json) {
    return CategoryPromo(
      id: json['id'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
