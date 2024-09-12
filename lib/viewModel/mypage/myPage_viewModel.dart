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
                  welcomeMessage: "돌아오셨군요!\n 다시 만나 반가워요 :)")
          )
      );
    }
  }

  //// 비밀번호 변경 로직
  // 현재 비밀번호 확인
  Future<void> checkPassword(BuildContext context, int userId) async {
    isCorrect = await dataSource.checkPassword(userId, nowPassword);
    if (isCorrect) {
      _showSnackBar(context, "확인 되었습니다.");
    } else {
      _showSnackBar(context, "다시 확인해주세요.");
    }
  }

  // 비밀번호 변경
  Future<void> updateNewPassword(BuildContext context, int userId) async {
    User? updatedUser = await dataSource.updateNewPassword(userId, newPassword);
    if (updatedUser != null && isCorrect) { //현재 비밀번호 확인 체크
      _showDialog(context);
    } else {
      _showSnackBar(context, "비밀번호 변경에 실패했습니다.");
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
          title: Text("비밀번호가 변경되었습니다."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("확인"),
            ),
          ],
        );
      },
    );
  }

}