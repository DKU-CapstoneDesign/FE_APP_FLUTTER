import 'package:capstonedesign/dataSource/user_dataSource.dart';
import 'package:capstonedesign/view/screens/mypage/changePWPage.dart';
import 'package:flutter/material.dart';
import '../../../model/user.dart';
import '../../../viewModel/mypage/myPage_viewModel.dart';

class MyPage extends StatefulWidget {
  final User user;
  MyPage ({required this.user});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = MypageViewModel(UserDataSource());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: Text(
                            widget.user.nickname.isNotEmpty ? widget.user.nickname[0] : '?',
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ),
                        SizedBox(width: 24),
                        Text(
                          widget.user.nickname, //bottomnavbar를 통해 전달받는 user(로그인 한 유저)의 이름을 보여줌
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: 'SejonghospitalBold',
                          ),
                        ),
                        SizedBox(width: 16),
                        IntrinsicWidth( //country 글자 수에 따라 컨테이너의 넓이가 정해질 수 있도록
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 20.0), // 글자 좌우에 여백 주기
                            height: 35,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(92, 67, 239, 50),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              widget.user.country, // BottomNavBar를 통해 전달받는 user(로그인 한 유저)의 나라를 보여줌
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'SejonghospitalBold',
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: TextButton.icon(
                        icon: Icon(Icons.logout_rounded, color: Colors.black38),
                        onPressed: () => viewModel.logout(context),
                        label: const Text(
                          "로그아웃",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "SejonghospitalLight",
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 17,
                width: double.infinity,
                color: Color.fromRGBO(245, 245, 245, 20),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 60, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "나의 기록",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'SejonghospitalBold',
                      ),
                    ),
                    SizedBox(height: 30),
                    TextButton.icon(
                      onPressed: () => null,
                      icon: Icon(Icons.favorite_outline, color: Colors.black38),
                      label: const Text(
                        "좋아요 누른 글               >",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "SejonghospitalLight",
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton.icon(
                      onPressed: () => null,
                      icon: Icon(Icons.ballot, color: Colors.black38),
                      label: const Text(
                        "내가 작성한 글               >",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "SejonghospitalLight",
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton.icon(
                      onPressed: () => null,
                      icon: Icon(Icons.bookmark_border_rounded, color: Colors.black38),
                      label: const Text(
                        "스크랩한 축제               >",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "SejonghospitalLight",
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 17,
                width: double.infinity,
                color: Color.fromRGBO(245, 245, 245, 20),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 100, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "설정",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'SejonghospitalBold',
                      ),
                    ),
                    SizedBox(height: 30),
                    TextButton.icon(
                        onPressed: () => null,
                        icon: Icon(Icons.language, color: Colors.black38),
                        label: const Text("언어 설정",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "SejonghospitalLight",
                            color: Colors.black,
                          ),
                        )
                    ),
                    SizedBox(height: 20),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangePWPage(user: widget.user)));
                        },
                        icon: Icon(Icons.key_sharp, color: Colors.black38),
                        label: const Text("비밀번호 변경하기",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "SejonghospitalLight",
                            color: Colors.black,
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

