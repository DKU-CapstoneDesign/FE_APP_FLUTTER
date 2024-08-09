import 'package:flutter/material.dart';
import 'postListPage.dart';

class ForumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(92, 67, 239, 60),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("게시판",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontFamily: 'SejonghospitalBold',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Column(
                  children: [
                    _buildBoardButton(context, '🔥 HOT 게시물',Colors.black54),
                    _buildBoardButton(context, '자유 게시판',Colors.black54),
                    _buildBoardButton(context, '도움 게시판',Colors.black54),
                    _buildBoardButton(context, '여행 게시판', Colors.black54),
                  ],
                ),
            ),
            SizedBox(height: 55.0),
          ],
        ),
      ),
    );
  }

  Widget _buildBoardButton(BuildContext context, String boardName, Color color) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostListPage(boardName: boardName)),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            boardName,
            style: TextStyle(fontSize: 20, color: color),
          ),
        ],
      ),
    );
  }
}
