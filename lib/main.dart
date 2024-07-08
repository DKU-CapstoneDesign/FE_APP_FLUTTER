import 'package:capstonedesign/view/screens/first/firstLogoPage.dart';
import 'package:flutter/material.dart';

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

