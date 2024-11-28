import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../login&signup/signupPage.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(40, 100, 40, 0),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "어떤 언어가 편하신가요?",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'SejonghospitalLight',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Image.asset(
                      "assets/img/globe.png",
                      width: 200,
                      height: 200,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    context.setLocale(Locale('ko', 'KR'));
                    Navigator.of(context).push(_createRoute(SignUpPage()));
                  },
                  child: Text(
                    "한국어",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Sejonghospital',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromRGBO(92, 67, 239, 50),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    minimumSize: Size(250, 50),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.setLocale(Locale('en', 'US'));
                    Navigator.of(context).push(_createRoute(SignUpPage()));
                  },
                  child: Text(
                    "English",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Sejonghospital',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromRGBO(92, 67, 239, 50),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    minimumSize: Size(250, 50), // 버튼 크기 설정
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 페이지 슬라이드 및 페이드 애니메이션
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // 오른쪽에서 들어옴
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        );

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: offsetAnimation,
            child: child,
          ),
        );
      },
    );
  }
}