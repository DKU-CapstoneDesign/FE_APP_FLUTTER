import 'package:capstonedesign/view/screens/first/firstLogoPage.dart';
import 'package:capstonedesign/viewModel/first/homePage_viewModel.dart';
import 'package:capstonedesign/viewModel/login&signup/loginPage_viewModel.dart';
import 'package:capstonedesign/viewModel/login&signup/signupPage_viewModel.dart';
import 'package:capstonedesign/viewModel/mypage/myPage_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dataSource/discover_dataSource.dart';
import 'dataSource/fortune_dataSource.dart';
import 'dataSource/user_dataSource.dart';
import 'model/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First Logo Page',
      home: FirstLogoPage(),
      
    );
  }
}

