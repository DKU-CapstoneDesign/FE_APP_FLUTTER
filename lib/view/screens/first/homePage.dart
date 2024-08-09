import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../dataSource/cardForm_dataSource.dart';
import '../../../dataSource/fortune_dataSource.dart';
import '../../../model/cardForm.dart';
import '../../../viewModel/first/homePage_viewModel.dart';
import '../../widgets/postListView.dart';
import '../discover/discoverPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Track selected tab
  bool isFestivalSelected = true;

  // Dummy posts for the 축제 tab
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
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(
        cardFormDatasource: CardFormDatasource(),
        fortuneDataSource: FortuneDataSource(),
      )..loadInitialData(),
      child: Scaffold(
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search, size: 28),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DiscoverPage()),
                            );
                          },
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isFestivalSelected = true;
                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'DISCOVER',
                                      style: TextStyle(
                                        fontSize: 22,  // Increase the font size
                                        color: isFestivalSelected ? Color.fromRGBO(92, 67, 239, 60) : Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SejonghospitalBold',
                                      ),
                                    ),
                                    if (isFestivalSelected)
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        height: 3,  // Increase the underline thickness
                                        width: 40,
                                        color: Color.fromRGBO(92, 67, 239, 60),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 40),  // Increased spacing between buttons
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isFestivalSelected = false;
                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'TODAY',
                                      style: TextStyle(
                                        fontSize: 22,  // Increase the font size
                                        color: !isFestivalSelected ? Color.fromRGBO(92, 67, 239, 60) : Colors.grey,
                                        fontFamily: 'SejonghospitalBold',
                                      ),
                                    ),
                                    if (!isFestivalSelected)
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        height: 3,  // Increase the underline thickness
                                        width: 40,
                                        color: Color.fromRGBO(92, 67, 239, 60)
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 28), // Align the layout properly with additional space on the right
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          PostListView(
                            cardForms: isFestivalSelected
                                ? (viewModel.festivals.isNotEmpty ? viewModel.festivals.map((festival) {
                              return CardForm(
                                title: festival.title,
                                content: festival.content,
                                imageUrl: festival.imageUrl,
                              );
                            }).toList() : dummyPosts)
                                : [], // Empty list for hot 게시글
                          ),
                          const SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Text(
                              "오늘의 운세",
                              style: const TextStyle(fontSize: 23,fontFamily: 'SejonghospitalLight',),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                child: Text(
                                  viewModel.fortuneToday,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}