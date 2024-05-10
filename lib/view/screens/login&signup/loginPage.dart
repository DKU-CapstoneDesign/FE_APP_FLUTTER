import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:capstonedesign/view/screens/mainPage.dart';
import 'package:capstonedesign/view/screens/login&signup/signupPage.dart';

void main() {
  runApp(LoginPage());
}

class AuthService {
  static const String baseUrl = 'https://true-porpoise-uniformly.ngrok-free.app/api/login';

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl'),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // 로그인이 성공했을 때 처리할 코드
        return true;
      } else {
        // 로그인이 실패했을 때 처리할 코드
        return false;
      }
    } catch (e) {
      // 예외가 발생했을 때 처리할 코드
      return false;
    }
  }
}

class LoginPage extends StatelessWidget {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) => email = value,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) => password = value,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text("Login"),
                  onPressed: () async {
                    bool success = await authService.login(email, password);
                    if (success) {
                      _navigateToMainPage(context);
                    } else {
                      // 로그인 실패 시 처리
                    }
                  },
                ),
                ElevatedButton(
                  child: Text("Sign up"),
                  onPressed: () => _navigateToSignUpPage(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _navigateToMainPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MainPage()),
  );
}

void _navigateToSignUpPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignUpPage()),
  );
}
