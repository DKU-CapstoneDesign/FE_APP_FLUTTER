import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../dataSource/user_dataSource.dart';
import '../../../viewModel/login&signup/signupPage_viewModel.dart';
import 'package:country_picker/country_picker.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // 국가 선택 전 기본 텍스트
  String selectedCountry = tr("select_country");

  @override
  Widget build(BuildContext context) {
    //상태 관리
    return ChangeNotifierProvider(
        create: (_) => SignUpViewModel(UserDataSource()),


    child : Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 40, 100),
          child: Consumer<SignUpViewModel>(
            builder: (context, viewModel, child) {
              return Form(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      tr("signup_subtitle"),
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'SejonghospitalLight',
                      ),
                    ),
                    SizedBox(height: 60),


                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 20, fontFamily: "SejonghospitalLight"),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          // 이메일 입력칸, viewModel을 통해 입력 값이 model에 저장
                          child: TextFormField(
                            onChanged: (value) =>
                            viewModel.user.email = value,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                        Color.fromRGBO(92, 67, 239, 50),
                                        width: 3
                                    )
                                )
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        // 이메일 중복 체크
                        ElevatedButton(
                          onPressed: () async {
                            // viewModel를 통해 중복 여부를 받아옴
                            bool isDuplicate =
                            await viewModel.checkEmailDuplication();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                isDuplicate
                                    ? tr("email_not_available")
                                    : tr("email_available"),
                                )
                              )
                             );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color.fromRGBO(92, 67, 239, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            side: const BorderSide(
                                color: Color.fromRGBO(92, 67, 239, 50)),
                          ),
                          child: Text(tr("check_duplicate")),
                        ),
                      ],
                    ),
                    SizedBox(height: 70),


                    ////////////////////////////////
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 20, fontFamily: "SejonghospitalLight"),
                      ),
                    ),
                    // 비밀번호 입력칸, viewModel을 통해 입력 값이 model에 저장
                    TextFormField(
                      onChanged: (value) =>
                      viewModel.user.password = value,
                      decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(92, 67, 239, 50),
                                  width: 3))),
                      obscureText: true,
                    ),
                    SizedBox(height: 70),


                    ////////////////////////////////
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nickname",
                        style: TextStyle(
                            fontSize: 20, fontFamily: "SejonghospitalLight"),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          // 닉네임 입력칸, viewModel을 통해 입력 값이 model에 저장
                          child: TextFormField(
                            maxLength: 10,
                            onChanged: (value) =>
                            viewModel.user.nickname = value,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                        Color.fromRGBO(92, 67, 239, 50),
                                        width: 3))),
                          ),
                        ),
                        SizedBox(width: 20),
                        // 닉네임 중복 체크
                        ElevatedButton(
                          onPressed: () async {
                            bool isDuplicate =
                            await viewModel.checkNicknameDuplication();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(isDuplicate
                                    ? tr("nickname_not_available")
                                    : tr("nickname_available"),
                               ),
                              )
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color.fromRGBO(92, 67, 239, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            side: const BorderSide(
                                color: Color.fromRGBO(92, 67, 239, 50)),
                          ),
                          child: Text(tr("check_duplicate")),
                        ),
                      ],
                    ),
                    SizedBox(height: 70),



                    ////////////////////////////////
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Country",
                        style: TextStyle(
                            fontSize: 20, fontFamily: "SejonghospitalLight"),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: false,
                            onSelect: (Country country) {
                              setState(() {
                                selectedCountry =
                                country.displayName.split(' (')[0];
                                viewModel.user.country =
                                country.displayName.split(' (')[0];
                              });
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color.fromRGBO(92, 67, 239, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          side: const BorderSide(
                              color: Color.fromRGBO(92, 67, 239, 50)),
                        ),
                        child: Text(
                          selectedCountry,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),


                    ////////////////////////////////
                    SizedBox(height: 70),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Birthdate",
                        style: TextStyle(
                            fontSize: 20, fontFamily: "SejonghospitalLight"),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: viewModel.birthdateController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(92, 67, 239, 50),
                                  width: 3,
                                ),
                              ),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              viewModel.setBirthdate(pickedDate);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),

      // 회원가입 버튼
      bottomNavigationBar: Container(
        child: Container(
          width: double.infinity,
          height: 70,
          color: Color.fromRGBO(92, 67, 239, 50),
          child: Consumer<SignUpViewModel>(
            builder: (context, viewModel, child) {
              return TextButton(
                onPressed: () => viewModel.signup(context),
                child: Text(
                  tr("signup"),
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "SejonghospitalBold",
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    )
    );
  }
}