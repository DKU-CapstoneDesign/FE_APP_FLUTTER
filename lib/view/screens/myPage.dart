
import 'package:capstonedesign/model/cardForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/cards/postListView.dart';



class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<CardForm> dummyPosts = [
    CardForm(
      title: '플러터 개발 시작하기',
      content: '플러터는 구글에서 개발한 모바일 앱 개발 프레임워크입니다. 다트 언어를 사용하며, 단일 코드베이스로 iOS, Android 등 다양한 플랫폼에서 동작합니다.',
      imageUrl: 'https://www.swmaestro.org/static/sw/img/common/logo.png',
    ),
    CardForm(
      title: '프론트엔드 개발자 되는 법',
      content: '프론트엔드 개발자가 되려면 HTML, CSS, JavaScript를 반드시 배워야 합니다. 또한 React, Vue, Angular 등의 프레임워크 학습도 필수적입니다. 실무 경험을 위해 개인 프로젝트도 진행하는 것이 좋습니다.',
      imageUrl: 'https://www.adm.ee/wordpress/wp-content/uploads/2023/08/JAVA-768x512.png',
    ),
    CardForm(
      title: '파이썬 기초 공부하기',
      content: '파이썬은 인공지능, 데이터 분석, 웹 개발 등 다양한 분야에서 활용되는 프로그래밍 언어입니다. 기본 문법과 자료 구조, 모듈과 패키지 등을 학습하면 파이썬 프로그래밍에 입문할 수 있습니다.',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Python-logo-notext.svg/1200px-Python-logo-notext.svg.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("마이 페이지"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 30, left: 30, right: 30),
            child: Row(
              children: [
                Image.asset(
                  'assets/DefaultProfile.png',
                  width: 100,
                ),
                SizedBox(width: 24,),
                Text(
                  "홍길동 님",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 16,),
                Image.asset(
                  "assets/flag_UK.png",
                  width: 50,
                )
              ],
            ),
          ),
          SizedBox(height: 30,),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text(
                      "누른 좋아요",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  PostListView(cardForms: dummyPosts),
                  SizedBox(height: 50,),

                  Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text(
                      "작성글",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
}
