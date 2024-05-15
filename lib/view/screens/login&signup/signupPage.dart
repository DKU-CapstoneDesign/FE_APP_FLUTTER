import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SignUpViewModel extends ChangeNotifier {
  String email = '';
  String password = '';
  String nickname = '';
  String country = '';
  String birthdate = '';
  bool emailCheck = false;
  bool nicknameCheck = false;

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

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (context) => SignUpViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text('회원가입')),
        body: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignUpViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              onChanged: (value) => viewModel.email = value,
              decoration: InputDecoration(
                labelText: '이메일',
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: viewModel.emailCheck,
                  onChanged: (value) async {
                    final duplication = await viewModel.checkEmailDuplication(viewModel.email);
                    print("!!!!!!!!!!!$value");
                    if (duplication) {
                      viewModel.setEmailCheck(true);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('중복된 이메일입니다.'),
                          ),
                      );
                    } else {
                      viewModel.setEmailCheck(false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('사용할 수 있는 이메일입니다.'),
                        ),
                      );
                    }
                  },
                ),
                Text('이메일 중복 체크'),
              ],
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => viewModel.password = value,
              decoration: InputDecoration(
                labelText: '비밀번호',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => viewModel.nickname = value,
              decoration: InputDecoration(
                labelText: '닉네임',
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: viewModel.nicknameCheck,
                  onChanged: (value) async {
                    final duplication = await viewModel.checkNicknameDuplication(viewModel.nickname);
                    viewModel.setNicknameCheck(duplication);
                    if (duplication) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('중복된 닉네임입니다.'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('사용할 수 있는 닉네임입니다.'),
                        ),
                      );
                    }
                  },
                ),
                Text('닉네임 중복 체크'),
              ],
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => viewModel.country = value,
              decoration: InputDecoration(
                labelText: '국가',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => viewModel.birthdate = value,
              decoration: InputDecoration(
                labelText: '생년월일',
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => viewModel.signUp(context),
              child: Text('가입하기'),
            ),
          ],
        ),
      ),
    );
  }
}
