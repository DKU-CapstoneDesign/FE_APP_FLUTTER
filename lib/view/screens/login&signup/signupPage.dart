//email, password, nickname, country

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstonedesign/viewModel/login&signup/signupPage_viewModel.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text('회원가입')),
        body: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignUpViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              onChanged: (value) => viewModel.email = value,
              decoration: InputDecoration(
                labelText: '이메일',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => viewModel.password = value,
              decoration: InputDecoration(
                labelText: '비밀번호',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => viewModel.nickname = value,
              decoration: InputDecoration(
                labelText: '닉네임',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => viewModel.country = value,
              decoration: InputDecoration(
                labelText: '국가',
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => viewModel.signUp(),
              child: Text('가입하기'),
            ),
          ],
        ),
      ),
    );
  }
}