import 'package:flutter/material.dart';
import 'postDetailPage.dart';
import 'post_model.dart';
import 'createPostPage.dart';

class PostListPage extends StatelessWidget {
  final String boardName;

  PostListPage({super.key, required this.boardName});

  // 임시 게시물 리스트
  final List<Post> posts = [
    Post(title: '제목 1', content: '내용 1'),
    Post(title: '제목 2', content: '내용 2'),
    Post(title: '제목 3', content: '내용 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(boardName),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(posts[index].title),
            subtitle: Text(posts[index].content),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailPage(post: posts[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.center,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => createPostPage()),
            );
          },
          child: const Text('글쓰기'),
        ),
      ),
    );
  }
}
