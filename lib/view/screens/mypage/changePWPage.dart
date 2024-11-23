import 'package:capstonedesign/dataSource/user_dataSource.dart';
import 'package:capstonedesign/viewModel/mypage/myPage_viewModel.dart';
import 'package:easy_localization/easy_localization.dart';
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
          title: Text(
            tr("change_password_title"),
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
                            decoration: InputDecoration(
                              labelText: tr("current_password_label"),
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
                          child: Text(
                            tr("check_button"),
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
                      decoration: InputDecoration(
                        labelText: tr("new_password_label"),
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
                          padding: const EdgeInsets.fromLTRB(70, 15, 70, 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          tr("change_password_button"),
                          style: TextStyle(
                            fontSize: 18,
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