import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/login&signup/signupPage_viewModel.dart';
import 'package:country_picker/country_picker.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //국가 선택 전 기본 텍스트
  String selectedCountry = '클릭하여 국가를 선택하세요';

  @override
  Widget build(BuildContext context) {
    //provider를 이용해 상태 관리
    //main.dart에서 전체 관리 중
    final viewModel = Provider.of<SignUpViewModel>(context);
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 40, 100),
            child: Form(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  const Text("코리너의 회원이 되어\n사람들과 소통해보세요!",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'SejonghospitalLight',
                    ),
                  ),
                  SizedBox(height: 60),


                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Email",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "SejonghospitalLight"
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        //이메일 입력칸, viewmodel을 통해 입력 값이 model에 저장
                        child: TextFormField(
                          onChanged: (value) => viewModel.user.email = value,
                          decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color : Color.fromRGBO(92, 67, 239, 50),
                                      width: 3
                                  )
                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      //이메일 중복 체크
                      ElevatedButton(
                        onPressed: () async {
                          //viewmodel를 통해 중복 여부를 받아옴
                          bool isDuplicate = await viewModel.checkEmailDuplication();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isDuplicate ? '사용할 수 없는 이메일입니다.' : '사용할 수 있는 이메일입니다.'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(253, 247, 254, 10),
                          foregroundColor: Color.fromRGBO(92, 67, 239, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          side: BorderSide(color: Color.fromRGBO(92, 67, 239, 50)),
                        ),
                        child: Text('중복 확인'),
                      ),
                    ],
                  ),
                  SizedBox(height: 70),


                  ////////////////////////////////
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Password",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "SejonghospitalLight"
                      ),
                    ),
                  ),
                  //비밀번호 입력칸, viewmodel을 통해 입력 값이 model에 저장
                  TextFormField(
                    onChanged: (value) => viewModel.user.password = value,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color : Color.fromRGBO(92, 67, 239, 50),
                                width: 3
                            )
                        )
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 70),


                  ////////////////////////////////
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Nickname",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "SejonghospitalLight"
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        //닉네임 입력칸, viewmodel을 통해 입력 값이 model에 저장
                        child: TextFormField(
                          maxLength: 10,
                          onChanged: (value) => viewModel.user.nickname = value,
                          decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color : Color.fromRGBO(92, 67, 239, 50),
                                      width: 3
                                  )
                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      //닉네임 중복체크
                      ElevatedButton(
                        onPressed: () async {
                          bool isDuplicate = await viewModel.checkNicknameDuplication();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isDuplicate ? '사용할 수 없는 닉네임입니다.' : '사용할 수 있는 닉네임입니다.'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(253, 247, 254, 10),
                          foregroundColor: Color.fromRGBO(92, 67, 239, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          side: BorderSide(color: Color.fromRGBO(92, 67, 239, 50)),
                        ),
                        child: Text('중복 확인'),
                      ),
                    ],
                  ),
                  SizedBox(height: 70),


                  ////////////////////////////////
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Country",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "SejonghospitalLight"
                      ),
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
                              selectedCountry = country.displayName.split(' (')[0];
                              viewModel.user.country = country.displayName.split(' (')[0];
                            });
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(253, 247, 254, 10),
                        foregroundColor: Color.fromRGBO(92, 67, 239, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        side: BorderSide(color: Color.fromRGBO(92, 67, 239, 50))
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
                    child: Text("Birthdate",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "SejonghospitalLight"
                      ),
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
            ),
          ),
        ),

        //회원가입 버튼
        bottomNavigationBar: Container(
          child:
            Container(
              width: double.infinity,
              height: 70,
              color: Color.fromRGBO(92, 67, 239, 50),
              child: TextButton(
                  onPressed: () => viewModel.signup(context),
                  child: const Text("회원가입",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "SejonghospitalBold",
                      color: Colors.white
                    ),
                  )
              ),
            ),
        )
      );
  }
}
