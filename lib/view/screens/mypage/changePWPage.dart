import 'package:capstonedesign/dataSource/user_dataSource.dart';
import 'package:capstonedesign/viewModel/mypage/myPage_viewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/user.dart';

class ChangePWPage extends StatefulWidget {
  @override
  _ChangePWState createState() => _ChangePWState();
}

class _ChangePWState extends State<ChangePWPage> {
  Widget build(BuildContext context) {
    // 상태 관리
    return ChangeNotifierProvider(
      create: (_) => MypageViewModel(UserDataSource()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            '비밀번호 변경하기',
            style: TextStyle(
              fontFamily: 'SejonghospitalLight',
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // 뒤로가기 아이콘
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        // consumer를 이용한 상태 관리
        /*provider 대신 consumer를 사용한 이유??
         => 상태 관리를 더 명확하게 하고, 특정 위젯들만 다시 빌드할 수 있기 때문*/
        body: Consumer<MypageViewModel>(
          builder: (context, viewModel, child) {
            return Align(
              alignment: const Alignment(0, -0.1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) => viewModel.nowPassword = value,
                            obscureText: true, //비밀번호 숨기기
                            decoration: const InputDecoration(
                              labelText: '현재 비밀번호',
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(92, 67, 239, 50),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          onPressed: () {
                            //viewModel.checkPassword(context, user.id);
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: const BorderSide(
                              color: Color.fromRGBO(92, 67, 239, 50),
                              width: 2.0, // Border width
                            ),
                          ),
                          child: const Text(
                            '확인',
                            style: TextStyle(
                              color: Color.fromRGBO(92, 67, 239, 50),
                              fontFamily: "SejonghospitalBold",
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      onChanged: (value) => viewModel.newPassword = value,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: '새로운 비밀번호',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:Color.fromRGBO(92, 67, 239, 50),
                            width: 3.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 130),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.updateNewPassword(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(92, 67, 239, 50),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.fromLTRB(75, 15, 75, 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "비밀번호 변경하기",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "SejonghospitalBold",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}