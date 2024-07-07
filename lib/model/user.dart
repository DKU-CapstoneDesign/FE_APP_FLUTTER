class User {
  String email;
  String password;
  String nickname;
  String country;

  User({
    required this.email,
    required this.password,
    required this.nickname,
    required this.country});
}

class LoginUser extends User {
  LoginUser({required String email, required String password})
      : super(email: email, password: password, nickname: '', country: '');
}
