class TopCollection {
  final String id;
  final String label;
  final String title;
  final String imageUrl;

  const TopCollection({
    required this.id,
    required this.label,
    required this.title,
    required this.imageUrl,
  });

  factory TopCollection.fromJson(Map<String, dynamic> json) {
    return TopCollection(
      id: json['id'] as String,
      label: json['label'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
