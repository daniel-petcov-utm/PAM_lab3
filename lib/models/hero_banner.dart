class HeroBanner {
  final String id;
  final String title;
  final String imageUrl;
  final String action;
  final int slides;
  final int activeSlide;

  const HeroBanner({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.action,
    required this.slides,
    required this.activeSlide,
  });

  factory HeroBanner.fromJson(Map<String, dynamic> json) {
    return HeroBanner(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      action: json['action'] as String,
      slides: json['slides'] as int,
      activeSlide: json['activeSlide'] as int,
    );
  }
}
