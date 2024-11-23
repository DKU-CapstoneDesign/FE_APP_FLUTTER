import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:capstonedesign/dataSource/post_dataSource.dart';
import 'package:capstonedesign/model/discover_festival.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../dataSource/chatting_dataSource.dart';
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
  final ChattingDataSource datasource = ChattingDataSource();
  DiscoverFestival errorPost = DiscoverFestival(
    name: tr("home_no_data"),
    image_url: "https://img.freepik.com/free-vector/error-404-concept-for-landing-page.jpg",
    address: "",
    period: "",
    detail_info: tr("home_contact_admin"),
  );

  int notificationCount = 0; // 알림 갯수 변수

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomePageViewModel>(context, listen: false).fetchMessage(widget.user.nickname);
    });
    _loadNotificationCount(); // 초기 알림 갯수 로드
    _initializeData(); // 기타 초기 데이터 로드
  }

  // 알림 갯수 로드
  Future<void> _loadNotificationCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationCount = prefs.getInt('notification_count') ?? 0;
    });
  }

  // 알림 갯수 초기화
  Future<void> _resetNotificationCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('notification_count', 0);
    setState(() {
      notificationCount = 0;
    });
  }

  // 초기 데이터 로드 메소드
  void _initializeData() async {
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
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(92, 67, 239, 5),
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

                      // 알림 아이콘에 갯수 뱃지 표시
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications),
                            onPressed: () async {
                              await _resetNotificationCount();
                            },
                          ),
                          if (notificationCount > 0)
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '$notificationCount',
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                        ],
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

                            // 축제 목록
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

                            // 최신 글
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 40, 0, 20),
                              child: Text(
                                tr("home_latest_posts"),
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
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          for (int index = 0;
                                          index < (viewModel?.posts.length ?? 0) && index < 3;
                                          index++)
                                            Padding(
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
                                                      viewModel.posts[index]['title'],
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: 'Sejonghospitallight',
                                                      ),
                                                    ),
                                                    subtitle: Padding(
                                                      padding: const EdgeInsets.only(top: 4.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              viewModel.posts[index]['contents'],
                                                              style: const TextStyle(
                                                                fontFamily: 'Sejonghospital',
                                                                fontSize: 16,
                                                              ),
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                          Text(
                                                              tr(
                                                                "home_like_count", // 좋아요 텍스트
                                                                namedArgs: {
                                                                  "likeCount": viewModel.posts[index]['likeCount'].toString()
                                                                },
                                                              ),
                                                            style: TextStyle(color: Colors.grey),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            tr(
                                                            "home_comment_count", // 댓글 텍스트
                                                            namedArgs: {
                                                              "commentCount": viewModel.posts[index]['commentList'].length
                                                            },
                                                          ),
                                                            style: TextStyle(color: Colors.grey),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => ChangeNotifierProvider(
                                                            create: (_) => PostDetailViewModel(
                                                                PostDataSource(),
                                                                widget.user,
                                                                CommentDatasource()),
                                                            child: PostDetailPage(
                                                                postId: viewModel.posts[index]['id'],
                                                                boardName: "HOT 게시판",
                                                                currentUserNickname: widget.user.nickname,
                                                                user: widget.user),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // 운세
                            Padding(
                              padding: EdgeInsets.fromLTRB(40, 40, 0, 20),
                              child: Text(
                                tr("home_today_fortune"),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Sejonghospitalbold',
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                  '"${viewModel.fortuneToday}"',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Sejonghospital',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
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