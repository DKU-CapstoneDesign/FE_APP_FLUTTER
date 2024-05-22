import 'package:flutter/material.dart';
import 'package:capstonedesign/dataSource/user_dataSource.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginDataSource _userDataSource = LoginDataSource();

  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  Future<bool> login() async {
    if (_email.isEmpty || _password.isEmpty) {
      return false;
    }

    bool success = await _userDataSource.login(_email, _password);
    return success;
  }
}
