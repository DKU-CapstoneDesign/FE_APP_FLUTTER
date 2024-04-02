import 'package:flutter/material.dart';
import 'package:capstonedesign/model/user.dart';
import 'package:capstonedesign/repository/user_repository.dart';
import 'package:capstonedesign/dataSource/user_dataSource.dart';

class SignUpViewModel extends ChangeNotifier {
  final UserRepository userRepository = UserRepository(userDataSource: UserDataSource());

  String _email = '';
  String _password = '';
  String _nickname = '';
  String _country = '';

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  set nickname(String value) {
    _nickname = value;
    notifyListeners();
  }

  set country(String value) {
    _country = value;
    notifyListeners();
  }

  Future<void> signUp() async {
    try {
      User newUser = User(email: _email, password: _password, nickname: _nickname, country: _country);
      await userRepository.signUp(newUser);
      // 회원가입 성공 시 처리
    } catch (e) {
      // 오류 처리
      print('가입 오류: $e');
    }
  }
}
