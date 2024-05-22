import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//회원가입
class SignUp extends ChangeNotifier {
  String? email;
  String? password;
  String? nickname;
  String? country;
  //
  // Future<void> signUp() async {
   // final url = 'http://192.168.0.208:8080/api/chat';
   //  final data = {
   //    'email': email,
   //    'password': password,
   //    'nickname': nickname,
   //    'country': country,
   //  };

    // final response = await http.post(
    //   // Uri.parse(url),
    //   body: jsonEncode(data),
    //   headers: {'Content-Type': 'application/json'},
    // );

  //   if (response.statusCode == 200) {
  //     // 회원가입 성공
  //     print('회원가입 성공');
  //   } else {
  //     // 회원가입 실패
  //     print('회원가입 실패: ${response.reasonPhrase}');
  //   }
  // }
}


//로그인
class LoginDataSource {
  static const String baseUrl = 'https://port-0-be-springboot-128y2k2llvky8epy.sel5.cloudtype.app';
  //'https://true-porpoise-uniformly.ngrok-free.app/api/login';

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl'+ "/api/login"),
        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        print("로그인 성공");
        return true;
      } else {
        print("로그인 실패");
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}

