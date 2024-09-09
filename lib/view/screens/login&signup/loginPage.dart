import 'package:capstonedesign/dataSource/user_dataSource.dart';
import 'package:capstonedesign/view/screens/login&signup/middlePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/login&signup/loginPage_viewModel.dart';

class LoginPage extends StatefulWidget {
  final String welcomeMessage; // 기존 회원과 신규 회원의 환영 메시지를 다르게 설정
  //navigate 시 매개변수로 전달 받음
  LoginPage({Key? key, required this.welcomeMessage}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    //상태 관리
    return ChangeNotifierProvider(
        create: (_) => LoginViewModel(UserDataSource()),

      child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back), // 뒤로가기 아이콘
        onPressed: () {
        Navigator.pushReplacement(
        context,
          MaterialPageRoute(builder: (context) => MiddlePage()),
         );},
        ),
      ),
      //consumer를 이용한 상태 관리
      /*provider 대신 consumer를 사용한 이유??
      => 상태 관리를 더 명확하게 하고, 특정 위젯들만 다시 빌드할 수 있기 때문*/
      body: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          return Padding(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 80),
                Text(
                  widget.welcomeMessage,
                  style: const TextStyle(
                    fontSize: 30,
                    fontFamily: 'SejonghospitalLight',
                  ),
                ),
                const SizedBox(height: 80),
                // 이메일 입력칸, viewModel을 통해 입력 값이 model에 저장
                TextField(
                  onChanged: (value) => viewModel.email = value,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Email',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(92, 67, 239, 50),
                        width: 3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // 비밀번호 입력칸, viewModel을 통해 입력 값이 model에 저장
                TextField(
                  onChanged: (value) => viewModel.password = value,
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(92, 67, 239, 50),
                        width: 3,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 230),
                ElevatedButton(
                  onPressed: () {
                    viewModel.login(context);
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "로그인",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "SejonghospitalBold",
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    )
    );
  }
}