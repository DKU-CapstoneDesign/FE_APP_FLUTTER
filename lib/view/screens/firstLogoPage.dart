import 'package:flutter/material.dart';
import 'dart:async';
import 'login&signup/middlePage.dart';

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
        MaterialPageRoute(builder: (context) => MiddlePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor:Color.fromRGBO(92, 67, 239, 60),
      body: Center(
        child: Image(
          image: AssetImage("assets/logo/logo_white.png"),
            width: 200,
            height: 200,),

        )
    );
  }
}
