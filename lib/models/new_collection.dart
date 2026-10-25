class NewCollection {
  final String label;
  final String title;
  final String imageUrl;

  const NewCollection({
    required this.label,
    required this.title,
    required this.imageUrl,
  });

  factory NewCollection.fromJson(Map<String, dynamic> json) {
    return NewCollection(
      label: json['label'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
