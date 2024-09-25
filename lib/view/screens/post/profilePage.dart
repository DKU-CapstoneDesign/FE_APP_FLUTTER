import 'package:capstonedesign/dataSource/user_dataSource.dart';
import 'package:flutter/material.dart';
import '../../../model/user.dart';
import '../../../viewModel/post/profilePage_viewModel.dart';

class ProfilePage extends StatefulWidget{
  String otherUserNickname;
  ProfilePage({required this.otherUserNickname});

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage>{
  @override
  Widget build(BuildContext context){
    final viewModel = ProfileViewModel(UserDataSource());
    return Scaffold(
      body : Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Column(
            children: <Widget>[
        Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,

                ),
                SizedBox(width: 24),

                SizedBox(width: 16),
                IntrinsicWidth(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 35,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(92, 67, 239, 50),
                      borderRadius: BorderRadius.circular(10),
                    ),

                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: TextButton.icon(
                icon: Icon(Icons.logout_rounded, color: Colors.black38),
                onPressed: () => {},
                label: const Text(
                  "채팅하기",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "SejonghospitalLight",
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ],
    ),
    ),
    );
  }
}