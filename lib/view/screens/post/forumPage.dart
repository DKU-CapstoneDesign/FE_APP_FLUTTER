import 'package:flutter/material.dart';
import 'postListPage.dart';

class ForumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "FORUM",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: const Text(
                '📌 기본 게시판',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    _buildBoardButton(context, '자유 게시판', Icons.push_pin, Colors.black54),
                    const Divider(color: Colors.grey),
                    _buildBoardButton(context, '도움 게시판', Icons.push_pin, Colors.black54),
                    const Divider(color: Colors.grey),
                    _buildBoardButton(context, '여행 게시판', Icons.push_pin, Colors.black54),
                  ],
                ),
              ),
            ),
            SizedBox(height: 55.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '🔥 HOT 게시물',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PostListPage(boardName: '🔥 HOT 게시물')),
                      );
                    },
                    child: Text('더보기'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Center(child: Text('제목 1')),
                  ),
                  const Divider(indent: 40, endIndent: 40, color: Colors.grey),
                  ListTile(
                    title: Center(child: Text('제목 2')),
                  ),
                  const Divider(indent: 40, endIndent: 40, color: Colors.grey),
                  ListTile(
                    title: Center(child: Text('제목 3')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoardButton(BuildContext context, String boardName, IconData iconData, Color color) {
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
          Icon(iconData, color: color),
          SizedBox(width: 8),
          Text(
            boardName,
            style: TextStyle(fontSize: 15, color: color),
          ),
        ],
      ),
    );
  }
}
