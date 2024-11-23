import 'package:easy_localization/easy_localization.dart';
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
        id: 0,
        cookie: ''
    );
  }

  // 회원가입 로직
  Future<void> signup(BuildContext context) async {
    if (user.email.isEmpty ||
        user.password.isEmpty ||
        user.nickname.isEmpty ||
        user.country.isEmpty ||
        user.birthDate.isEmpty) {
      _showDialog(context, tr('signup_failure'), tr('signup_fill_all_fields'));
      return;
    }

    if (!emailCheck || !nicknameCheck) {
      _showDialog(context,  tr('signup_failure'), tr('signup_check_duplicates'));
      return;
    }

    User? signupUser = await dataSource.signUp(
      user.email,
      user.password,
      user.nickname,
      user.country,
      user.birthDate,
    );

    if (signupUser != null) {
      _showDialog(context,  tr('signup_success'), tr('signup_success_message'));
    } else {
      _showDialog(context, tr('signup_failure'), tr('signup_retry'));
    }
  }

  // 회원가입 성공/실패 다이얼로그 표시
  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
            title == tr('signup_success') ? _navigateToLoginPage(context) : Navigator.of(context).pop(),
            child:Text(tr('confirm')),
          ),
        ],
      ),
    );
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage(welcomeMessage: tr("welcome_message_signup")))
    );
  }

  // 생년월일을 String으로 변환 및 형식 지정
  void setBirthdate(DateTime date) {
    user.birthDate = "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    birthdateController.text = user.birthDate;
    notifyListeners();
  }

  void setEmailCheck(bool value) {
    emailCheck = value;
    notifyListeners();
  }

  void setNicknameCheck(bool value) {
    nicknameCheck = value;
    notifyListeners();
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