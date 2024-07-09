import 'dart:convert';
import 'package:http/http.dart' as http;


class UserDataSource {
  String baseUrl = 'https://port-0-be-springboot-128y2k2llvky8epy.sel5.cloudtype.app';
      //'https://true-porpoise-uniformly.ngrok-free.app/api';

  //////로그인
  Future<void> login(String email, String password) async{
      try {
        final response = await http.post(
          Uri.parse('$baseUrl/login'),
          body: {
            'email': email,
            'password': password,
          },
        );
        if (response.statusCode == 200) {
          print("로그인 성공");
        } else {
          print("로그인 실패");
        }
      } catch (e) {
         print(e);
      }
  }

  //////회원가입
  Future<void> signUp(String email,String password,String nickname, String country) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: {
          'email': email,
          'password': password,
          'nickname': nickname,
          'country': country,
        },
      );
      if (response.statusCode == 200) {
        print("회원가입 성공");
      } else {
        print("회원가입 실패");
      }
    } catch (e) {
      print(e);
    }
  }

  //////로그아웃
  Future<bool> logout() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/logout'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('loggedOut') &&
            responseData['loggedOut'] == true) {
          print("로그아웃 성공");
          return true;
        } else {
          print("로그아웃 실패");
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
