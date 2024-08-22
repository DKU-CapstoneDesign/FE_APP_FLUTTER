// import 'package:capstonedesign/dataSource/user_dataSource.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:capstonedesign/view/screens/login&signup/loginPage.dart';
// import 'package:provider/provider.dart';
//
// import '../../../model/user.dart';
//
// class MyPage extends StatefulWidget {
//   final User user;
//   MyPage({required this.user});
//
//   @override
//   State<MyPage> createState() => _MyPageState();
// }
//
// class _MyPageState extends State<MyPage> {
//   //provider를 이용해 상태 관리
//   //main.dart에서 전체 관리 중
//   final viewModel = Provider.of<UserDataSource>(context);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Image.asset(
//                         'assets/img/defaultProfile.png',
//                         width: 70,
//                       ),
//                       SizedBox(width: 24),
//                       const Text(
//                         '$user.username',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontFamily: 'SejonghospitalBold',
//                         ),
//                       ),
//                       SizedBox(width: 16),
//                       Container(
//                         alignment: Alignment.center,
//                         width: 60,
//                         height: 35,
//                         decoration: BoxDecoration(
//                           color: Color.fromRGBO(92, 67, 239, 50),
//                           borderRadius:BorderRadius.circular(10),
//                         ),
//                         child: const Text(
//                           "$user.country",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 16,
//                             color : Colors.white,
//                             fontFamily: 'SejonghospitalBold',
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   Center(
//                     child: TextButton.icon(
//                       icon: Icon(Icons.logout_rounded, color: Colors.black38),
//                       onPressed: () => viewModel.logout(),
//                       label: const Text(
//                         "로그아웃",
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontFamily: "SejonghospitalLight",
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               height: 17,
//               width: double.infinity,
//               color: Color.fromRGBO(245, 245, 245, 20),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 30, 60, 30),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "나의 기록",
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontFamily: 'SejonghospitalBold',
//                     ),
//                   ),
//                   SizedBox(height: 30),
//                   TextButton.icon(
//                     onPressed: () => null,
//                     icon: Icon(Icons.favorite_outline, color: Colors.black38),
//                     label: const Text(
//                       "좋아요 누른 글               >",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontFamily: "SejonghospitalLight",
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextButton.icon(
//                     onPressed: () => null,
//                     icon: Icon(Icons.ballot, color: Colors.black38),
//                     label: const Text(
//                       "내가 작성한 글               >",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontFamily: "SejonghospitalLight",
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 17,
//               width: double.infinity,
//               color: Color.fromRGBO(245, 245, 245, 20),
//             ),
//             const Padding(
//               padding: EdgeInsets.fromLTRB(0, 30, 230, 30),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "설정",
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontFamily: 'SejonghospitalBold',
//                     ),
//                   ),
//                   SizedBox(height: 30),
//                   Text(
//                     "언어 설정",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontFamily: "SejonghospitalLight",
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
