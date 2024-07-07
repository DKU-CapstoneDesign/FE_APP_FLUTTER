import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';


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
}
