class User {
  String email;
  String password;
  String nickname;
  String country;
  String birthDate;

  User({
    required this.email,
    required this.password,
    required this.nickname,
    required this.country,
    required this.birthDate,
  });

  // JSON으로부터 User 객체 생성
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      nickname: json['nickname'] ?? '',
      country: json['country'] ?? '',
      birthDate: json['birthDate'] ?? '',
    );
  }

  // User 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'nickname': nickname,
      'country': country,
      'birthDate': birthDate,
    };
  }
}
