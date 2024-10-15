import 'package:capstonedesign/dataSource/post_dataSource.dart';
import 'package:capstonedesign/model/discover_festival.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../dataSource/comment_dataSource.dart';
import '../../../dataSource/discover_dataSource.dart';
import '../../../dataSource/fortune_dataSource.dart';
import '../../../model/discover_festival.dart';
import '../../../model/discover_sight.dart';
import '../../../model/user.dart';
import '../../../viewModel/first/homePage_viewModel.dart';
import '../../../viewModel/post/postDetailPage_viewModel.dart';
import '../../widgets/postListView.dart';
import '../post/postDetailPage.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFestivalSelected = true; // 탭바 컨트롤을 위한 변수

  //만약 정보를 가져오지 못했을 경우 에러를 표시함
  DiscoverFestival errorPost = DiscoverFestival(
    name:'정보를 불러오지 못했습니다.',
    image_url:  "https://img.freepik.com/free-vector/error-404-concept-for-landing-page_23-2148237748.jpg?w=1380&t=st=1725265497~exp=1725266097~hmac=d7a95048d969f691ccefe06c9d42eadd35021b0542f025271d0ca609a3945969",
    address: "",
    period : "",
    detail_info : '관리자에게 연락해주세요',
  );


  @override
  void initState() {
    super.initState();
    // 운세
    String birthMonth = widget.user.birthDate.substring(5, 7);
    String birthDay = widget.user.birthDate.substring(8, 10);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<HomePageViewModel>(context, listen: false);
      await viewModel.getFortune(birthMonth,birthDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    //상태 관리
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
                                    viewModel.getPostList(widget.user);
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

                  //// 탭바 아래 나올 내용
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          // PostListView 위젯을 이용해서 내용 컨트롤

                          // DISCOVER를 눌렀을 떄
                          // 축제 정보를 가져옴
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: isFestivalSelected
                                ? PostListView(
                              cardForms: //viewModel.festivals.isNotEmpty
                                   //` ? viewModel.festivals.map((festival) {
                               /* return DiscoverFestival(
                                  name: festival?.name,
                                  image_url: festival.image_url,
                                  address: festival.address,
                                  period : festival.period,
                                  detail_info : festival.detail_info
                                );*/
                              //}).toList()
                                   [errorPost],
                            )

                            //TODAY를 눌렀을 때
                                : Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Container(
                                width: double.infinity,
                                height: 500.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.0),
                                  color: Color(0xFFEDE7F6),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                                        child: Text(
                                          "최신 글, 지금 바로 확인하세요!",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Sejonghospital',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                                        child: ListView.builder(
                                          itemCount: (viewModel?.posts.length ?? 0) > 4 ? 4 : viewModel.posts.length,
                                          itemBuilder: (context, index) {
                                            var post = viewModel.posts[index];
                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: 10.0),
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
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                          builder: (context) => ChangeNotifierProvider(
                                                            create: (_) => PostDetailViewModel(PostDataSource(), widget.user, CommentDatasource()),
                                                            child: PostDetailPage(
                                                                postId: post['id'],
                                                                boardName: "HOT 게시판",
                                                                currentUserNickname: widget.user.nickname,
                                                                user: widget.user
                                                            ),
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 60),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "오늘의 운세",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'SejonghospitalBold',
                                    color: Color(0xFF4A4A4A),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Divider(
                                  indent: 150,
                                  endIndent: 150,
                                ),
                                SizedBox(height: 10),
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