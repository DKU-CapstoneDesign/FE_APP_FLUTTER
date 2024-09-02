class Discover {
  final String title;
  final String content;
  final String imageUrl;

  Discover({
    required this.title,
    required this.content,
    required this.imageUrl
  });

  // JSON으로부터 User 객체 생성
  factory Discover.fromJson(Map<String, dynamic> json) {
    return Discover(
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'],
    );
  }
}
