
import 'package:capstonedesign/model/cardForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../widgets/cards/postListView.dart';



class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List festivals = [];
  List sights = [];

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

  Future<void> fetchSights() async {
    final response = await http.get(
        // Uri.parse('http://ec2-44-223-67-116.compute-1.amazonaws.com:8080/sight/get-sights/'),
        Uri.parse('http://127.0.0.1:8080/sight/get-sights/'),
        headers: {
          'Accept': 'application/json; charset=utf-8',
        }
    );
    if (response.statusCode == 200) {
      setState(() {
        sights = jsonDecode(utf8.decode(response.bodyBytes));
        print(sights.runtimeType);
        print(sights[1].runtimeType);
      });
    } else {
      throw Exception('Failed to load sights');
    }
  }


  @override
  void initState() {
    super.initState();
    fetchFestivals();
    fetchSights();
  }


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

    List<CardForm> sightPosts = sights.map((sight) {
      final title = sight['name'];
      final content = sight['detail_info'];
      final imageUrl = sight['image_url'];

      return CardForm(
        title: title,
        content: content,
        imageUrl: imageUrl,
      );
    }).toList();

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

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.only(left: 24),
                child: Text(
                  "search",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 16,),
                  SizedBox(
                    width: 300,
                    height: 45,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "어디로 가세요?",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  // SizedBox(width: 2,),
                  IconButton(
                    icon: Icon(Icons.search),
                    iconSize: 40,
                    onPressed: () {
          
                    },
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Text(
                  "주변 명소",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              PostListView(
                cardForms: sightPosts != null && sightPosts.isNotEmpty
                    ? sightPosts
                    : dummyPosts,
              ),
              SizedBox(height: 50,),

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
                  "쇼핑",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              PostListView(cardForms: dummyPosts),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
