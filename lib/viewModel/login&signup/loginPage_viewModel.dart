import 'package:flutter/material.dart';
import 'package:capstonedesign/model/user.dart';
import 'package:capstonedesign/dataSource/user_dataSource.dart';

import '../../view/widgets/bottomNavBar.dart';

class LoginViewModel extends ChangeNotifier {
  late User user;
  late UserDataSource dataSource;
  late BuildContext context;

  LoginViewModel(this.dataSource) {
    user = LoginUser(email: '', password: '');
  }

  //로그인 로직
  Future<void> login(BuildContext context) async {
    LoginUser? loggedUser = await dataSource.login(user.email, user.password);
    if (loggedUser != null) { //만약 데이터를 전송 받았다면
      _navigateToHomePage(context); //로그인 성공(홈페이지로 이동)
    } else {
      _showErrorDialog(context);
    }
    notifyListeners();
  }


  //로그인 성공 시 homepage로 이동
  void _navigateToHomePage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavBar()));
  }
  //로그인 실패 시 실패 다이얼로그 띄우기
  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("로그인에 실패하셨습니다"),
          content: Text("확인 후 다시 시도하세요"),
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



