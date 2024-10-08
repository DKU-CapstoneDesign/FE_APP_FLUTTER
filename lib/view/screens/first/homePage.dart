import 'package:capstonedesign/dataSource/post_dataSource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../dataSource/discover_dataSource.dart';
import '../../../dataSource/fortune_dataSource.dart';
import '../../../model/discover.dart';
import '../../../viewModel/first/homePage_viewModel.dart';
import '../../widgets/postListView.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFestivalSelected = true; // 탭바 컨트롤을 위한 변수

  //만약 정보를 가져오지 못했을 경우 에러를 표시함
  Discover errorPost = Discover(
    title: '정보를 불러오지 못했습니다.',
    content: '관리자에게 연락해주세요',
    imageUrl:
    "https://img.freepik.com/free-vector/error-404-concept-for-landing-page_23-2148237748.jpg?w=1380&t=st=1725265497~exp=1725266097~hmac=d7a95048d969f691ccefe06c9d42eadd35021b0542f025271d0ca609a3945969",
  );

  @override
  Widget build(BuildContext context) {
    //상태 관리
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(
        discoverDatasource: DiscoverDatasource(),
        fortuneDataSource: FortuneDataSource(),
        postDataSource: PostDataSource(),
      )..loadInitialData(), //loadInitialData()를 통해 데이터를 즉시 가져오기

      child: Scaffold(
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.notifications, color: Colors.grey, size: 30),
                          onPressed: () {
                            // 알림
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Row(
                      children: [
                        const SizedBox(width: 40),
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
                                        fontSize: 20,
                                        color: isFestivalSelected ? Color.fromRGBO(92, 67, 239, 60) : Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SejonghospitalBold',
                                      ),
                                    ),
                                    if (isFestivalSelected)
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        height: 3,
                                        width: 40,
                                        color: Color.fromRGBO(92, 67, 239, 60),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 40),
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
                                        fontSize: 20,
                                        color: !isFestivalSelected ? Color.fromRGBO(92, 67, 239, 60) : Colors.grey,
                                        fontFamily: 'SejonghospitalBold',
                                      ),
                                    ),
                                    if (!isFestivalSelected)
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        height: 3,
                                        width: 40,
                                        color: Color.fromRGBO(92, 67, 239, 60),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 28),
                      ],
                    ),
                  ),

                  //탭바 아래 나올 내용
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          // PostListView 위젯을 이용해서 내용 컨트롤

                          // DISCOVRT를 눌렀을 떄
                          isFestivalSelected
                              ? PostListView(
                            cardForms: viewModel.festivals.isNotEmpty
                                ? viewModel.festivals.map((festival) {
                              return Discover(
                                title: festival.title,
                                content: festival.content,
                                imageUrl: festival.imageUrl,
                              );
                            }).toList()
                                : [errorPost],
                          )

                          //TODAY를 눌렀을 때
                              : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: viewModel.posts.length, // 핫 게시물의 개수
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 180,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              viewModel.posts[index].title,
                                              style: const TextStyle(
                                                fontSize: 22,
                                                color: Colors.white,
                                                fontFamily: 'SejonghospitalBold',
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Divider(
                                              color: Colors.white,
                                              thickness: 1,
                                            ),
                                            SizedBox(height: 10.0),
                                            const Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "자세히 보기                  >",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontFamily: 'SejonghospitalLight',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 60),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  " 오늘의 운세 ",
                                  style: TextStyle(fontSize: 20, fontFamily: 'SejonghospitalLight'),
                                ),
                                const SizedBox(height: 10),
                                const Divider(
                                  indent: 150,
                                  endIndent: 150,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  ' ❝    ${viewModel.fortuneToday}    ❞',
                                  style: const TextStyle(fontSize: 20, fontFamily: 'Sejonghospitallight'),
                                ),
                                SizedBox(height: 100),
                              ],
                            ),
                          )
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