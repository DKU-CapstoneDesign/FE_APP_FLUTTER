import 'package:flutter/material.dart';
import '../../dataSource/user_dataSource.dart';
import '../../model/user.dart';
import '../../view/screens/login&signup/loginPage.dart';

class SignUpViewModel extends ChangeNotifier {
  late User user;
  late UserDataSource dataSource;
  DateTime birthdate = DateTime.now();
  final birthdateController = TextEditingController();

  // 중복 체크를 했는지 확인하는 변수
  bool emailCheck = false;
  bool nicknameCheck = false;

  SignUpViewModel(this.dataSource) {
    user = User(
      email: '',
      password: '',
      nickname: '',
      country: '',
      birthDate: '',
    );
  }

  // 회원가입 로직
  Future<void> signup(BuildContext context) async {
    User? signupUser = await dataSource.signUp(
      user.email,
      user.password,
      user.nickname,
      user.country,
      user.birthDate,
    );
    print(signupUser);

    if (signupUser != null) {
      _navigateToLoginPage(context); //회원가입 성공 시 로그인 페이지로 이동
    } else {
      _showDialog(context, '회원가입 실패', '회원가입에 실패하였습니다.\n다시 시도하세요.');
    }
  }

  //로그인 성공 시 signuppage로 이동
  void _navigateToLoginPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage(welcomeMessage: "반가워요!\n만나서 반갑습니다 :)")));
  }
  // 회원가입 실패 다이얼로그 표시
  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  // 생년월일을 String으로 변환 및 형식 지정
  void setBirthdate(DateTime date) {
    // DateTime 객체를 "YYYY-MM-DD" 형식의 문자열로 변환
    user.birthDate = "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    birthdateController.text = user.birthDate;
    notifyListeners(); // 상태가 변하면 UI에 알림 보내기
  }

  void setEmailCheck(bool value) {
    emailCheck = value;
    notifyListeners(); //상태가 변하면 ui에 알림 보내기
  }

  void setNicknameCheck(bool value) {
    nicknameCheck = value;
    notifyListeners(); //상태가 변하면 ui에 알림 보내기
  }

  // 이메일 중복 체크
  Future<bool> checkEmailDuplication() async {
    bool duplication = await dataSource.checkEmailDuplication(user.email);
    setEmailCheck(!duplication); // 중복이 없으면 true, 중복이 있으면 false
    return duplication;
  }

  // 닉네임 중복 체크
  Future<bool> checkNicknameDuplication() async {
    bool duplication = await dataSource.checkNicknameDuplication(user.nickname);
    setNicknameCheck(!duplication); // 중복이 없으면 true, 중복이 있으면 false
    return duplication;
  }


}