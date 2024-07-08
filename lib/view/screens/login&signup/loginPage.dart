import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../dataSource/user_dataSource.dart';
import '../../../viewModel/login&signup/loginPage_viewModel.dart';
import '../../widgets/bottomNavBar.dart';
import 'signupPage.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(UserDataSource()),
      child: Consumer<LoginViewModel>(
        builder : (context, LoginViewModel, child){
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
                  TextField(
                        onChanged: LoginViewModel.setEmail,
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
                  TextField(
                        onChanged: LoginViewModel.setPassword,
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
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context)=> BottomNavBar())
                            );
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
      )
    );
  }
}
