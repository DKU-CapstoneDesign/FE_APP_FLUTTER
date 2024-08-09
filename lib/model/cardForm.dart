class CardForm {
  final String title;
  final String content;
  final String imageUrl;

  CardForm({required this.title, required this.content, required this.imageUrl});

  factory CardForm.fromJson(Map<String, dynamic> json) {
    return CardForm(
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'],
    );
  }
}
