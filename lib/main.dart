import 'package:capstonedesign/dataSource/chatting_dataSource.dart';
import 'package:capstonedesign/dataSource/post_dataSource.dart';
import 'package:capstonedesign/view/screens/first/firstLogoPage.dart';
import 'package:capstonedesign/viewModel/post/postDetailPage_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MyApp(),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First Logo Page',
      home: FirstLogoPage(),
      
    );
  }
}

