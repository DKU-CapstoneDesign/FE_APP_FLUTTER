import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:capstonedesign/dataSource/post_dataSource.dart';
import 'package:capstonedesign/model/discover_festival.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../dataSource/comment_dataSource.dart';
import '../../../model/user.dart';
import '../../../viewModel/first/homePage_viewModel.dart';
import '../../../viewModel/post/postDetailPage_viewModel.dart';
import '../../widgets/postListView.dart';
import '../post/postDetailPage.dart';
import 'package:loading_indicator/loading_indicator.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //만약 정보를 가져오지 못했을 경우 에러를 표시함
  DiscoverFestival errorPost = DiscoverFestival(
    name: '정보를 불러오지 못했습니다.',
    image_url:
    "https://img.freepik.com/free-vector/error-404-concept-for-landing-page_23-2148237748.jpg?w=1380&t=st=1725265497~exp=1725266097~hmac=d7a95048d969f691ccefe06c9d42eadd35021b0542f025271d0ca609a3945969",
    address: "",
    period: "",
    detail_info: '관리자에게 연락해주세요',
  );

  @override
  void initState() {
    super.initState();
    // 운세용
    String birthMonth = widget.user.birthDate.substring(5, 7);
    String birthDay = widget.user.birthDate.substring(8, 10);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<HomePageViewModel>(context, listen: false);
      await viewModel.getFortune(birthMonth, birthDay);
      await viewModel.getFestivals();
      await viewModel.getPostList(widget.user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomePageViewModel>(
        builder: (context, viewModel, child) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/logo/logo_purple.png",
                        width: 60,
                        height: 60,
                      ),

                      //// 로고 글자에 애니메이션 넣기
                      //animated_text_kit 패키지 사용
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(92, 67, 239, 60),
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'Koreigner',
                              speed: const Duration(milliseconds: 300),
                            )
                          ],
                          totalRepeatCount: 1,
                          pause: const Duration(milliseconds: 1000),
                          displayFullTextOnTap: true,
                          stopPauseOnTap: true,
                        ),
                      ),

                      IconButton(
                        icon: const Icon(Icons.notifications, color: Colors.grey, size: 30),
                        onPressed: () {
                          // 알림
                        },
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Consumer<HomePageViewModel>(
                    builder: (context, viewModel, child) {
                      // 데이터 받아올 때까지 로딩 화면
                      // loading_indicator 패키지 이용
                      if (viewModel.loading) {
                        return const Center(
                          child: SizedBox(
                            width: 60,
                            height: 60,
                            child: LoadingIndicator(
                              indicatorType: Indicator.ballPulseSync,
                              colors: [
                                Color.fromRGBO(92, 67, 239, 100),
                                Color.fromRGBO(92, 67, 239, 60),
                                Color.fromRGBO(92, 67, 239, 20),
                              ],
                            ),
                          ),
                        );
                      }

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),

                            //// 축제
                            PostListView(
                              cardForms: viewModel.festivals.isNotEmpty
                                  ? viewModel.festivals.map((festival) {
                                return DiscoverFestival(
                                    name: festival!.name,
                                    image_url: festival.image_url,
                                    address: festival.address,
                                    period: festival.period,
                                    detail_info: festival.detail_info);
                              }).toList()
                                  : [errorPost],
                            ),

                            //// 최신 글
                            const Padding(
                              padding: EdgeInsets.fromLTRB(40, 40, 0, 20),
                              child: Text(
                                "최신 글, 지금 바로 확인하세요!",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Sejonghospitalbold',
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 400,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEDE7F6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: (viewModel?.posts.length ?? 0) > 3
                                            ? 3
                                            : viewModel.posts.length,
                                        itemBuilder: (context, index) {
                                          var post = viewModel.posts[index];
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(14.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.2),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                                child: ListTile(
                                                  title: Text(
                                                    post['title'],
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: 'Sejonghospitallight',
                                                    ),
                                                  ),
                                                  subtitle: Padding(
                                                    padding: const EdgeInsets.only(top: 4.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(post['contents']),
                                                        ),
                                                        Text(
                                                          '좋아요 ${post['likeCount']}개',
                                                          style: TextStyle(color: Colors.grey),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChangeNotifierProvider(
                                                              create: (_) => PostDetailViewModel(
                                                                  PostDataSource(),
                                                                  widget.user,
                                                                  CommentDatasource()),
                                                              child: PostDetailPage(
                                                                  postId: post['id'],
                                                                  boardName: "HOT 게시판",
                                                                  currentUserNickname:
                                                                  widget.user.nickname,
                                                                  user: widget.user),
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //// 운세
                            const Padding(
                              padding: EdgeInsets.fromLTRB(40, 70, 0, 20),
                              child: Text(
                                "오늘의 운세",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Sejonghospitalbold',
                                ),
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '❝',
                                          style: TextStyle(fontSize: 20, fontFamily: 'Sejonghospitallight'),
                                        ),
                                        Text(
                                          '${viewModel.fortuneToday}',
                                          style: const TextStyle(fontSize: 20, fontFamily: 'Sejonghospitallight'),
                                          textAlign: TextAlign.center,
                                        ),
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '❞',
                                              style: TextStyle(fontSize: 20, fontFamily: 'Sejonghospitallight'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 100),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}