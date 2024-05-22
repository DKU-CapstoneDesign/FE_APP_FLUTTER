import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstonedesign/view/screens/mainPage.dart';
import 'package:capstonedesign/view/screens/login&signup/signupPage.dart';
import '../../../viewModel/login&signup/loginPage_viewModel.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer<LoginViewModel>(
                builder: (context, loginViewModel, child) {
                  return Column(
                    children: <Widget>[
                      TextField(
                        onChanged: (value) => loginViewModel.email = value,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        onChanged: (value) => loginViewModel.password = value,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text("Login"),
                            onPressed: () async {
                              bool success = await loginViewModel.login();
                              if (success) {
                                _navigateToMainPage(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
                              }
                            },
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            child: Text("Sign up"),
                            onPressed: () => _navigateToSignUpPage(context),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMainPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }

  void _navigateToSignUpPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }
}
