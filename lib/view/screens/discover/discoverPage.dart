import 'package:capstonedesign/model/cardForm.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'discoverDetailPage.dart';

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
      Uri.parse('http://127.0.0.1:8080/festival/get-festivals/'),
      headers: {
        'Accept': 'application/json; charset=utf-8',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        festivals = jsonDecode(utf8.decode(response.bodyBytes));
      });
    } else {
      throw Exception('Failed to load festivals');
    }
  }

  Future<void> fetchSights() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8080/sight/get-sights/'),
      headers: {
        'Accept': 'application/json; charset=utf-8',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        sights = jsonDecode(utf8.decode(response.bodyBytes));
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
        content: '플러터는 구글에서 개발한 모바일 앱 개발 프레임워크입니다.',
        imageUrl: 'https://www.swmaestro.org/static/sw/img/common/logo.png',
      ),
      CardForm(
        title: '프론트엔드 개발자 되는 법',
        content: '프론트엔드 개발자가 되려면 HTML, CSS, JavaScript를 반드시 배워야 합니다.',
        imageUrl: 'https://www.adm.ee/wordpress/wp-content/uploads/2023/08/JAVA-768x512.png',
      ),
      CardForm(
        title: '파이썬 기초 공부하기',
        content: '파이썬은 인공지능, 데이터 분석, 웹 개발 등 다양한 분야에서 활용되는 프로그래밍 언어입니다.',
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Python-logo-notext.svg/1200px-Python-logo-notext.svg.png',
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 300,
                    height: 45,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "어디로 가세요?",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    iconSize: 40,
                    onPressed: () {},
                  ),
                ],
              ),
              _buildGridView(sightPosts.isNotEmpty ? sightPosts : dummyPosts),
              _buildGridView(festivalPosts.isNotEmpty ? festivalPosts : dummyPosts),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridView(List<CardForm> posts) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3열 그리드
        crossAxisSpacing: 5, // 수평 간격
        mainAxisSpacing: 5, // 수직 간격
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DiscoverDetailPage(cardForm: posts[index]),
            ));
          },
          child: Image.network(
            posts[index].imageUrl,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}