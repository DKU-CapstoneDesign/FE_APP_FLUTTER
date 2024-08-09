class Fortune {
  final String answer;

  Fortune({required this.answer});

  factory Fortune.fromJson(Map<String, dynamic> json) {
    return Fortune(
      answer: json['answer'],
    );
  }
}