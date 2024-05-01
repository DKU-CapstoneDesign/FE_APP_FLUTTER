import 'package:flutter/material.dart';
import 'package:capstonedesign/model/user.dart';
import 'package:capstonedesign/repository/user_repository.dart';
import 'package:capstonedesign/dataSource/user_dataSource.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository = UserRepository(userDataSource: UserDataSource());

  String _email = '';
  String _password = '';

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  Future<void> login() async {
    try {
      User newUser = LoginUser(email: _email, password: _password);
     // await userRepository.login(newUser);
      // 회원가입 성공 시 처리
    } catch (e) {
      // 오류 처리
      print('가입 오류: $e');
    }
  }
}
