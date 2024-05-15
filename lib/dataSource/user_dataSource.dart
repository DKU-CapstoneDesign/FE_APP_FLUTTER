import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//회원가입 백엔드
class SignUp extends ChangeNotifier {
  String? email;
  String? password;
  String? nickname;
  String? country;

  Future<void> signUp() async {
    final url = 'http://192.168.0.208:8080/api/chat';
    final data = {
      'email': email,
      'password': password,
      'nickname': nickname,
      'country': country,
    };

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // 회원가입 성공
      print('회원가입 성공');
    } else {
      // 회원가입 실패
      print('회원가입 실패: ${response.reasonPhrase}');
    }
  }
}
