import 'package:flutter/material.dart';
import '../../dataSource/user_dataSource.dart';
import '../../model/user.dart';
import '../../view/screens/login&signup/loginPage.dart';

class MypageViewModel extends ChangeNotifier {
  late String nowPassword, newPassword;
  late UserDataSource dataSource;
  late BuildContext context;
  MypageViewModel(this.dataSource);

  // 로그아웃 로직
  Future<void> logout(BuildContext context) async {
    bool isLogout = await dataSource.logout();
    if (isLogout) {
      Navigator.push( // 로그아웃 성공 시 로그인 페이지로 이동
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage(
                  welcomeMessage: "돌아오셨군요!\n 다시 만나 반가워요 :)")));
    }
  }

  //// 비밀번호 변경 로직
  // 현재 비밀번호 확인
  Future<void> checkPassword(BuildContext context, int userId) async {
    bool isChecked = await dataSource.checkPassword(userId, nowPassword);
    if (isChecked) {
      _showSnackBar(context, "확인 되었습니다.");
    } else {
      _showSnackBar(context, "다시 확인해주세요.");
    }
  }

  // 비밀번호 변경
  Future<void> updateNewPassword(BuildContext context) async {
    // 비밀번호 변경 로직
  }


  // 스낵바 표시
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }
}