
import 'package:capstonedesign/model/cardForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../widgets/cards/postListView.dart';
import '../mypage/myPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List festivals = [];
  String fortune_today = '';
  String url = 'ec2-44-223-67-116.compute-1.amazonaws.com';

  Future<void> fetchFestivals() async {
    final response = await http.get(
        // Uri.parse('http://ec2-44-223-67-116.compute-1.amazonaws.com:8080/festival/get-festivals/'),
        Uri.parse('http://127.0.0.1:8080/festival/get-festivals/'),
        headers: {
          'Accept': 'application/json; charset=utf-8',
        }
    );
    if (response.statusCode == 200) {
      setState(() {
        festivals = jsonDecode(utf8.decode(response.bodyBytes));
        print(festivals.runtimeType);
        print(festivals[1].runtimeType);
      });
    } else {
      throw Exception('Failed to load festivals');
    }
  }

  Future<void> getFortune(String birth_month, String birth_day) async {
    final url = Uri.parse('http://127.0.0.1:8080/fortune/get-fortune/');
    final headers = {'Content-Type' : 'application/json'};
    final body = jsonEncode({'birth_month': birth_month, 'birth_day': birth_day});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      setState(() {
        final jsonResponse = jsonDecode(response.body);
        fortune_today = jsonResponse['answer'];
        print(fortune_today);
      });
    } else {
      throw Exception("failed to get fortune response");
    }

  }


  @override
  void initState() {
    super.initState();
    fetchFestivals();
    getFortune('1', '22');
  }



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
    List<CardForm> festivalPosts = festivals.map((festival) {
      final title = festival['name'];
      final content = festival['detail_info'];
      final imageUrl = festival['image_url'];

      return CardForm(
        title: title,
        content: content,
        imageUrl: imageUrl,
      );
    }).toList();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    // child: Image.asset(
                    //   'assets/koreignerLogo.png',
                    //   width: 180,
                    // ),
                  ),
                  IconButton(
                    icon: Icon(Icons.person),
                    iconSize: 40,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyPage()));
                    },
                  ),
                ],
              ),
              SizedBox(height: 30,),

              Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Text(
                  "축제",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              PostListView(
                cardForms: festivalPosts != null && festivalPosts.isNotEmpty
                    ? festivalPosts
                    : dummyPosts,
              ),
              SizedBox(height: 50,),

              Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Text(
                  "hot 게시글",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 50,),

              Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Text(
                  "광고",
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
                  "오늘의 운세",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 18, right: 18, top: 8),
                child: Text(
                  // "더미 운세입니다. 오늘은 변화와 성장의 시기입니다. 개인적인 변화나 새로운 도전에 과감히 나서보세요. 건강을 특히 주의하세요. 블라블라블라~~",
                  fortune_today,
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              ),
              SizedBox(height: 50,),

            ],
          ),
        ),
      ),
    );
  }
}
