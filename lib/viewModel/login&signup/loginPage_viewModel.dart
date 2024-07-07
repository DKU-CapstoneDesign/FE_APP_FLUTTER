import 'package:flutter/material.dart';
import 'package:capstonedesign/model/user.dart';
import 'package:capstonedesign/dataSource/user_dataSource.dart';

class LoginViewModel extends ChangeNotifier {
  final UserDataSource dataSource;
  LoginViewModel(this.dataSource);

  User loginUser = new LoginUser(email: '', password: '');
  String email= '', password = '';
  String idError = '';
  String passwordError = '';
  String errorMessage ="안됌";


  void setEmail(String value) {
    loginUser.email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    loginUser.password = value;
    notifyListeners();
  }


  bool login(email, password) {
    return true;
  }

}

