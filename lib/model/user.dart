class User {
  String email;
  String password;
  String nickname;
  String country;
  String birthdate;

  User({
    required this.email,
    required this.password,
    required this.nickname,
    required this.country,
    required this.birthdate,
  });


  //json으로부터 User 객체를 생성
  //회원가입 시 사용
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
      nickname: json['nickname'],
      country: json['country'],
      birthdate: json['birthdate'],
    );
  }

}


class LoginUser extends User {
  LoginUser({required String email, required String password})
      : super(email: email, password: password, nickname: '', country: '', birthdate: '');

  //json으로부터 User 객체를 생성
  //로그인 시 사용
  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
      email: json['email'],
      password: json['password'],
    );
  }
}
