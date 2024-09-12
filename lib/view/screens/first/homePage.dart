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
    imageUrl: "https://img.freepik.com/free-vector/error-404-concept-for-landing-page_23-2148237748.jpg?w=1380&t=st=1725265497~exp=1725266097~hmac=d7a95048d969f691ccefe06c9d42eadd35021b0542f025271d0ca609a3945969"
  );

  @override
  Widget build(BuildContext context) {
    //상태 관리
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(
        discoverDatasource: DiscoverDatasource(),
        fortuneDataSource: FortuneDataSource(),
      )..loadInitialData(), //loadInitialData()를 통해 데이터를 즉시 가져오기


      child: Scaffold(
        //consumer를 이용한 상태 관리
        /*provider 대신 consumer를 사용한 이유??
         => 상태 관리를 더 명확하게 하고, 특정 위젯들만 다시 빌드할 수 있기 때문*/
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/logo/logo_purple.png',
                          height: 40,
                          width: 70,
                        ),
                        // 오른쪽 알림 아이콘
                        IconButton(
                          icon: Icon(Icons.notifications, color: Colors.grey,size: 30),
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
                          //탭바 타이틀 컨트롤
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
                                        color: Color.fromRGBO(92, 67, 239, 60)
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
                          //postListView 위젯을 이용해서 내용 컨트롤
                          ////축제 정보(discover)를 눌렀을 때
                          PostListView(
                            cardForms: isFestivalSelected
                                ? (viewModel.festivals.isNotEmpty
                                ? viewModel.festivals.map((festival) {
                              return Discover(
                                title: festival.title,
                                content: festival.content,
                                imageUrl: festival.imageUrl,
                              );
                            }).toList()
                                : [errorPost]) // 받아오지 못했다면 errorPost를 리스트로 전달

                            ////핫 게시물(today)을 눌렀을 때
                                : [],
                          ),
                          const SizedBox(height: 60),


                          //////////////////////////
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