import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../dataSource/user_dataSource.dart';

class SignUpViewModel extends ChangeNotifier {
  final UserDataSource dataSource;
  SignUpViewModel(this.dataSource);
  String email = '';
  String password = '';
  String nickname = '';
  String country = '';
  // String birthdate = '';
  bool emailCheck = false;
  bool nicknameCheck = false;

  DateTime birthdate = DateTime.now();
  final birthdateController = TextEditingController();

  void setBirthdate(DateTime date) {
    birthdate = date;
    birthdateController.text = "${date.year}-${date.month}-${date.day}";
    notifyListeners();
  }
  void setEmailCheck(bool? value) {
    if (value != null) {
      emailCheck = value;
      notifyListeners();
    }
  }

  void setNicknameCheck(bool? value) {
    if (value != null) {
      nicknameCheck = value;
      notifyListeners();
    }
  }

  Future<bool> checkEmailDuplication(String email) async {
    try {
      final response = await http.post(
        Uri.parse('https://true-porpoise-uniformly.ngrok-free.app/api/duplication/email'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['duplication'];
      } else {
        print('이메일 중복 체크 실패: ${response.body}');
        return true; // 일단 오류 시 중복으로 간주
      }
    } catch (e) {
      print('오류 발생: $e');
      return true; // 오류 시 중복으로 간주
    }
  }
//   if (duplication) {
//   viewModel.setEmailCheck(true);
//   ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//   content: Text('중복된 이메일입니다.'),
//   ),
//   );
//   } else {
//   viewModel.setEmailCheck(false);
//   ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//   content: Text('사용할 수 있는 이메일입니다.'),
//   ),
//   );
//   }
// },

  Future<bool> checkNicknameDuplication(String nickname) async {
    try {
      final response = await http.post(
        Uri.parse('https://true-porpoise-uniformly.ngrok-free.app/api/duplication/nickname'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nickname': nickname}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['duplication'];
      } else {
        print('닉네임 중복 체크 실패: ${response.body}');
        return true; // 일단 오류 시 중복으로 간주
      }
    } catch (e) {
      print('오류 발생: $e');
      return true; // 오류 시 중복으로 간주
    }
  }
  // if (duplication) {
  // viewModel.setNicknameCheck(true);
  // ScaffoldMessenger.of(context).showSnackBar(
  // SnackBar(
  // content: Text('중복된 닉네임입니다.'),
  // ),
  // );
  // } else {
  // viewModel.setEmailCheck(false);
  // ScaffoldMessenger.of(context).showSnackBar(
  // SnackBar(
  // content: Text('사용할 수 있는 닉네임입니다.'),
  // ),
  // );
  // }

  Future<void> signUp(BuildContext context) async {
    final formData = {
      'email': email,
      'password': password,
      'nickname': nickname,
      'country': country,
      'birthdate': birthdate,
    };

    try {
      final response = await http.post(
        Uri.parse('https://true-porpoise-uniformly.ngrok-free.app/api/signup'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: formData,
      );

      if (response.statusCode == 200) {
        // 회원가입 성공
        print('회원가입 성공');
        // 여기에 회원가입 성공 시 처리할 내용 추가
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('회원가입 성공'),
            content: Text('회원가입에 성공하였습니다.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
              ),
            ],
          ),
        );
      } else {
        // 회원가입 실패
        print('회원가입 실패: ${response.body}');
        // 여기에 회원가입 실패 시 처리할 내용 추가
      }
    } catch (e) {
      // 네트워크 오류 등 예외 처리
      print('오류 발생: $e');
      // 여기에 오류 발생 시 처리할 내용 추가
    }
  }
}
