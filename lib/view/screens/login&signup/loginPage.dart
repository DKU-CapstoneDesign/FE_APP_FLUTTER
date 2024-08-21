import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/login&signup/loginPage_viewModel.dart';


class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    //provider를 이용해 상태 관리
    //main.dart에서 전체 관리 중
    final viewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 80),
            const Text("돌아오셨군요!\n 다시 만나 반가워요 :)",
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'SejonghospitalLight',
              ),
            ),
            SizedBox(height: 80),
            //이메일 입력칸, viewmodel을 통해 입력 값이 model에 저장
            TextField(
                  onChanged: (value) => viewModel.user.email= value,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Email',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color : Color.fromRGBO(92, 67, 239, 50),
                        width: 3
                      )
                    )
                  ),
             ),
            SizedBox(height: 20),
            //비밀번호 입력칸, viewmodel을 통해 입력 값이 model에 저장
            TextField(
              onChanged: (value) => viewModel.user.password= value,
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color : Color.fromRGBO(92, 67, 239, 50),
                              width: 3
                          )
                      )
                  ),
            ),
            SizedBox(height: 230),
            ElevatedButton(
                    onPressed: () {
                      viewModel.login();
                      /////서버 안 켜져 있을 시 임시로 홈에 들어가기
                      // Navigator.push(
                      //     context, MaterialPageRoute(builder: (context)=> BottomNavBar())
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(92, 67, 239, 50),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(130, 15, 130, 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    child: const Text("로그인",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "SejonghospitalBold"
                      ),
                    )
            ),
          ],
        ),
      ),
    );
  }
}
