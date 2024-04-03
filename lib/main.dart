import 'package:flutter/material.dart';
import 'package:capstonedesign/view/screens/firstLogoPage.dart';

void main() {
  runApp(const MyApp());
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

