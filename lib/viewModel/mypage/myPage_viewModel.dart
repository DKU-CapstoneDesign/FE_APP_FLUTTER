import 'package:flutter/material.dart';

import '../../dataSource/user_dataSource.dart';
import '../../model/user.dart';
import '../../view/screens/login&signup/loginPage.dart';
import '../login&signup/loginPage_viewModel.dart';

class MypageViewModel{
  late UserDataSource dataSource;
  MypageViewModel(this.dataSource);

  // 로그아웃 로직
  Future<void> logout(BuildContext context) async {
    bool isLogout = await dataSource.logout();
    if (isLogout) {
      Navigator.push( //로그아웃 성공 시 로그인 페이지로 이동
          context, MaterialPageRoute(builder: (context)=> LoginPage(welcomeMessage: "돌아오셨군요!\n 다시 만나 반가워요 :)"))
      );
    }
  }


}