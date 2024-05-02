import 'package:flutter/material.dart';
import 'postListPage.dart';

class forumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("FORUM"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              child: const Text(
                '게시판',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PostListPage(boardName: '자유게시판')),
                      );
                    },
                    child: const Text('자유게시판'),
                  ),
                  const Divider(color: Colors.grey),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PostListPage(boardName: '도움게시판')),
                      );
                    },
                    child: const Text('도움게시판'),
                  ),
                  const Divider(color: Colors.grey),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PostListPage(boardName: '여행게시판')),
                      );
                    },
                    child: const Text('여행게시판'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'hot게시물',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PostListPage(boardName: 'hot게시물')),
                          );
                        },
                        child: Text('더보기'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Column(
                    children: [
                      Text("내요요용")
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
