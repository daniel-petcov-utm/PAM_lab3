class StoreTitle {
  final String title;

  const StoreTitle({required this.title});

  factory StoreTitle.fromJson(Map<String, dynamic> json) {
    return StoreTitle(title: json['storeName'] as String);
  }
}
