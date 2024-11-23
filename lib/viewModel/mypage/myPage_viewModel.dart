import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../dataSource/user_dataSource.dart';
import '../../model/user.dart';
import '../../view/screens/login&signup/loginPage.dart';

class MypageViewModel extends ChangeNotifier {
  late String nowPassword, newPassword;
  late UserDataSource dataSource;
  late BuildContext context;
  late bool isCorrect = false; //비밀번호 확인 체크
  MypageViewModel(this.dataSource);

  // 로그아웃 로직
  Future<void> logout(BuildContext context) async {
    bool isLogout = await dataSource.logout();
    if (isLogout) {
      Navigator.push( // 로그아웃 성공 시 로그인 페이지로 이동
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage(
                  welcomeMessage: tr("logout_success"),)
          )
      );
    }
  }

  //// 비밀번호 변경 로직
  // 현재 비밀번호 확인
  Future<void> checkPassword(BuildContext context, int userId) async {
    isCorrect = await dataSource.checkPassword(userId, nowPassword);
    if (isCorrect) {
      _showSnackBar(context, tr("password_confirmed"));
    } else {
      _showSnackBar(context, tr("password_check_failed"));
    }
  }

  // 비밀번호 변경
  Future<void> updateNewPassword(BuildContext context, int userId) async {
    User? updatedUser = await dataSource.updateNewPassword(userId, newPassword);
    if (updatedUser != null && isCorrect) { //현재 비밀번호 확인 체크
      _showDialog(context);
    } else {
      _showSnackBar(context, tr("password_change_failed"));
    }
  }


  //////////
  // 스낵바 표시
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }
  //비밀번호 변경 성공 시  다이얼로그 띄우기
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr("password_change_success")),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(tr("confirm")),
            ),
          ],
        );
      },
    );
  }

}