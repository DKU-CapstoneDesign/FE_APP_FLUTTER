import 'package:capstonedesign/dataSource/user_dataSource.dart';
import 'package:capstonedesign/view/screens/mypage/changePWPage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/translate/LanguageProvider.dart';
import '../../../model/user.dart';
import '../../../viewModel/discover/discoverPage_viewModel.dart';
import '../../../viewModel/mypage/myPage_viewModel.dart';

class MyPage extends StatefulWidget {
  final User user;
  MyPage ({required this.user});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  // 언어 설정을 클릭했을 때 한국어 & 영어
  void _selectLanguage(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text("한국어"),
            onPressed: () {
              context.setLocale(Locale('ko', 'KR')); // 한국어 로케일 설정
              Provider.of<DiscoverViewModel>(context, listen: false).getAllPosts();
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('English'),
            onPressed: () {
              context.setLocale(Locale('en', 'US')); // 영어 로케일 설정
              Provider.of<DiscoverViewModel>(context, listen: false).getAllPosts();
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(tr('cancel')),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }


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
                        label: Text(
                          tr("logout"),
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
                   Text(
                      tr("my_records"),
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'SejonghospitalBold',
                      ),
                    ),
                    SizedBox(height: 30),
                    TextButton.icon(
                      onPressed: () => null,
                      icon: Icon(Icons.favorite_outline, color: Colors.black38),
                      label: Text(
                        tr("liked_posts"),
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
                      label: Text(
                        tr("my_posts"),
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "SejonghospitalLight",
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton.icon(
                      onPressed:  () =>  null,
                      icon: Icon(Icons.bookmark_border_rounded, color: Colors.black38),
                      label: Text(
                        tr("scrapped_festivals"),
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
                    Text(
                      tr("settings"),
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'SejonghospitalBold',
                      ),
                    ),
                    SizedBox(height: 30),
                    TextButton.icon(
                       onPressed: ()=> _selectLanguage(context),
                        icon: Icon(Icons.language, color: Colors.black38),
                        label: Text(
                          tr("language_settings"),
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
                        label: Text(
                          tr("change_password"),
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

