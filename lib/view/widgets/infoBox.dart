import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Infobox extends StatelessWidget {
  final String title;   // 변수로 사용할 필드 선언
  final String subtitle;

  // 생성자를 통해 변수 값 전달
  Infobox(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          title == "환영해요! 게시판입니다."?
          Image.asset('assets/img/board.png', width: 50):
          Image.asset('assets/img/chat.png', width: 50),
          SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, // 전달받은 제목 사용
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  subtitle, // 전달받은 부제목 사용
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}