import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user.dart';


class UserDataSource {
  String baseUrl = 'http://158.180.86.243:8080';
      // 'https://port-0-be-springboot-128y2k2llvky8epy.sel5.cloudtype.app';
      //'https://true-porpoise-uniformly.ngrok-free.app/api';


  //////로그인
  Future<LoginUser?> login(String email, String password) async{
    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      print("로그인 성공");
      //model의 LoginUser에 값을 넣기
      return LoginUser.fromJson(jsonDecode(response.body));
    } else {
      print("로그인 실패");
      return null;
    }
  }

  //////회원가입
  //이메일 중복 체크
  Future<bool> checkEmailDuplication(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/duplication/email'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['duplication']; //중복 - true, 중복x - false
      } else {
        print('이메일 중복 체크 실패: ${response.body}');
        return true; //오류 시 중복으로 간주
      }
    } catch (e) {
      print('오류 발생: $e');
      return true; //오류 시 중복으로 간주
    }
  }
  //닉네임 중복 체크
  Future<bool> checkNicknameDuplication(String nickname) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/duplication/nickname'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nickname': nickname}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['duplication']; //중복 - true, 중복x - false
      } else {
        print('닉네임 중복 체크 실패: ${response.body}');
        return true; //오류 시 중복으로 간주
      }
    } catch (e) {
      print('오류 발생: $e');
      return true; //오류 시 중복으로 간주
    }
  }
  //회원가입하기
  //form 데이터 형식으로 post
  Future<User?> signUp(String email, String password, String nickname, String country, String birthdate) async {
    final formData = {
      'email': email,
      'password': password,
      'nickname': nickname,
      'country': country,
      'birthdate': birthdate,
    };
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/signup'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: formData,
      );
      if (response.statusCode == 200) {
        //model의 User에 값을 넣기
        return User.fromJson(jsonDecode(response.body));
      } else {
        print('회원가입 실패: ${response.body}');
        return null;
      }
    } catch (e) {
      print('에러 발생: $e');
      return null;
    }
  }


  //////로그아웃
  Future<bool> logout() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/logout'));
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
