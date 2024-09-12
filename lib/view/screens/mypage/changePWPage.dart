import 'package:capstonedesign/dataSource/user_dataSource.dart';
import 'package:capstonedesign/viewModel/mypage/myPage_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/user.dart';

class ChangePWPage extends StatefulWidget {
  final User user; // 비밀번호 확인에 필요
  ChangePWPage({Key? key, required this.user}) : super(key: key);

  @override
  _ChangePWState createState() => _ChangePWState();
}

class _ChangePWState extends State<ChangePWPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MypageViewModel(UserDataSource()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '비밀번호 변경하기',
            style: TextStyle(
              fontFamily: 'SejonghospitalLight',
            ),
          ),
          centerTitle: true,
        ),


        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            child: Consumer<MypageViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) => viewModel.nowPassword = value,
                            obscureText: true, // 비밀번호 숨기기
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
                            viewModel.checkPassword(context, widget.user.id);
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: const BorderSide(
                              color: Color.fromRGBO(92, 67, 239, 50),
                              width: 2.0,
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
                            color: Color.fromRGBO(92, 67, 239, 50),
                            width: 3.0,
                          ),
                        ),
                      ),
                    ),



                    const SizedBox(height: 50),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          viewModel.updateNewPassword(context, widget.user.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(92, 67, 239, 50),
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
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}