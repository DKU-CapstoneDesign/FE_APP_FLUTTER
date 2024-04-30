//email, password

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstonedesign/viewModel/loginPage_viewModel.dart';


class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child : Scaffold(
        appBar: AppBar(
          title : Text ('로그인'),
        ),
        body : LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final viewModel = Provider.of<LoginViewModel>(context);

    return Padding(
      padding : const EdgeInsets.all(16.0),
      child : Form(
        child : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children : <Widget>[
            TextFormField(
              onChanged : (value) => viewModel.email = value,
              decoration : InputDecoration(
                labelText: '이메일',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              onChanged: (value) => viewModel.password = value,
              decoration: InputDecoration(
                labelText: '비밀번호',
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
                onPressed: () => viewModel.login(),
                child: Text('로그인하기'),
            )
          ]
        )
      )
    );
  }
}