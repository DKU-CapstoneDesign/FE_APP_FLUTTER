import 'package:capstonedesign/dataSource/user_dataSource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/login&signup/signupPage_viewModel.dart';
import 'package:country_picker/country_picker.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String selectedCountry = '클릭하여 국가를 선택하세요';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (context) => SignUpViewModel(UserDataSource()),
      child: Consumer<SignUpViewModel>(
        builder: (context, viewModel, child) {
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
                            child: TextFormField(
                              onChanged: (value) => viewModel.email = value,
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
                          ElevatedButton(
                            onPressed: (){
                              viewModel.checkEmailDuplication(viewModel.email);
                            },
                            style:  ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(253, 247, 254, 10),
                                foregroundColor: Color.fromRGBO(92, 67, 239, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                side: BorderSide(color: Color.fromRGBO(92, 67, 239, 50))
                            ),
                            child : Text('중복 확인'),
                          ),
                        ],
                      ),
                      SizedBox(height: 70),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Password",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "SejonghospitalLight"
                          ),
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) => viewModel.password = value,
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
                            child: TextFormField(
                              maxLength: 6,
                              onChanged: (value) => viewModel.nickname = value,
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
                          ElevatedButton(
                            onPressed: (){
                              viewModel.checkEmailDuplication(viewModel.email);
                            },
                            style:  ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(253, 247, 254, 10),
                                foregroundColor: Color.fromRGBO(92, 67, 239, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                side: BorderSide(color: Color.fromRGBO(92, 67, 239, 50))
                            ),
                            child : Text('중복 확인'),
                          ),
                        ],
                      ),
                      SizedBox(height: 70),
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
                                  selectedCountry = country.displayName;
                                  viewModel.country = country.displayName;
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
            bottomNavigationBar: Container(
              child:
                Container(
                  width: double.infinity,
                  height: 70,
                  color: Color.fromRGBO(92, 67, 239, 50),
                  child: TextButton(
                      onPressed: () => viewModel.signUp(context),
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
        },
      ),
    );
  }
}
