import 'dart:ui';
import 'package:capstonedesign/view/screens/login&signup/loginPage.dart';
import 'package:capstonedesign/view/screens/login&signup/signupPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MiddlePage extends StatefulWidget {
  @override
  _MiddlePageState createState()=> _MiddlePageState();
}
class _MiddlePageState extends State<MiddlePage>{

  //로고 이미지에 애니메이션 넣기
  bool _visible = false;
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(milliseconds: 400),(){
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:  Padding(
        padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
        child: Center (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const Text("Koreigner",
                style:  TextStyle(
                  fontSize: 40,
                  letterSpacing: 2
                ),
              ),
              SizedBox(height: 5),
              const Text("서로를 잇는 가장 쉬운 연결",
                style: TextStyle(
                  fontSize: 23,
                  fontFamily: 'SejonghospitalLight',
                  color: Color.fromRGBO(92, 67, 239, 60),
                ),
              ),
              SizedBox(height: 5),
              AnimatedOpacity(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 1000),
                opacity: _visible ? 1:0,
                child: Image.asset(
                  "assets/logo/logo_purple.png",
                  width: 200,
                  height: 200,
                )
              ),
              SizedBox(height: 150),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context)=> SignUpPage())
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(92, 67, 239, 50),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  child: const Text("시작하기",
                    style: TextStyle(
                        fontSize: 20,
                      fontFamily: "SejonghospitalBold"
                    ),
                  )
              ),
              SizedBox(height: 10),
              TextButton(
                  onPressed: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context)=> LoginPage(welcomeMessage: "돌아오셨군요!\n 다시 만나 반가워요 :)"))
                    );
                  },
                  child: const Text("이미 계정이 있으신가요?",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                        fontFamily: "SejonghospitalLight"
                    ),
                  )
              ),
            ]
          ),
        ),
      ),
    );
  }
}
