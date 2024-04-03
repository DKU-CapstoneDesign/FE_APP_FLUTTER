import 'package:flutter/material.dart';
import 'dart:async';
import 'package:capstonedesign/view/screens/loginPage.dart';

class FirstLogoPage extends StatefulWidget {
  @override
  _FirstLogoPageState createState() => _FirstLogoPageState();
}

class _FirstLogoPageState extends State<FirstLogoPage> {

  //3초 후 로그인 화면으로 이동
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('koreigner'),
      ),
    );
  }
}
