import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user.dart';


class UserDataSource {
  String baseUrl = 'http://158.180.86.243:8080';
      // 'https://port-0-be-springboot-128y2k2llvky8epy.sel5.cloudtype.app';
      //'https://true-porpoise-uniformly.ngrok-free.app/api';

  //////로그인
  Future<User?> login(String email, String password) async{
    try{
      final response = await http.post(
        Uri.parse('$baseUrl/api/login'),
        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        print("로그인 성공");
        final Map<String, dynamic> responseData = json.decode(response.body);
        // responseData에서 데이터 추출
        final loginUser = responseData['authentication']['principal'];
        // User 객체로 변환하여 반환;
        return User.fromJson(loginUser);
      } else {
        print("로그인 실패: : ${response.body}");
        return null;
      }
    } catch(e){
      print('오류 발생: $e');
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
  Future<User?> signUp(String email, String password, String nickname, String country, String birthDate) async {
    final formData = {
      'email': email,
      'password': password,
      'nickname': nickname,
      'country': country,
      'birthDate': birthDate,
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
        if (responseData.containsKey('loggedOut') && responseData['loggedOut'] == true) {
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



  //////비밀번호 변경
  //현재 비밀번호 확인
  Future<bool> checkPassword(int userId, String password) async{
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/check/password'),
        headers: {'Content-Type':  'application/json'},
        body: jsonEncode({
          'userId': userId,
          'password':  password,
        }),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if(responseData){
          print('현재 비밀번호 확인 성공');
          return responseData;
        } else {
          print('현재 비밀번호 확인 실패');
          return responseData;
        }
      } else {
        print('현재 비밀번호 확인 실패: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      print('에러 발생: $e');
      return false;
    }
  }

  //새로운 비밀번호로 업데이트
  Future<User?> updateNewPassword(int userId, String newPassword) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/modify/password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print('새로운 비밀번호 업데이트 성공');
        return User.fromJson(responseData);
      } else {
        print('새로운 비밀번호 업데이트 실패: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('에러 발생: $e');
      return null;
    }
  }
}
