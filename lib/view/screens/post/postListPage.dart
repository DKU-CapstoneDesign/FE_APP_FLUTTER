import 'package:flutter/material.dart';
import 'package:capstonedesign/view/screens/post/postDetailPage.dart';
import 'package:capstonedesign/model/post.dart';
import 'package:capstonedesign/view/screens/post/createPostPage.dart';

class PostListPage extends StatelessWidget {
  final String boardName;

  PostListPage({Key? key, required this.boardName}) : super(key: key);

  // 임시 게시물 리스트
  final List<Post> posts = [
    Post(
      title: '제목 1',
      content: '내용 1',
      id: 0,
      uploaderId: 0,
      created_at: DateTime(2024, 1, 1),
      likes: 0,
      views: 0,
    ),
    Post(
      title: '제목 2',
      content: '내용 2',
      id: 1,
      uploaderId: 1,
      created_at: DateTime(2024, 1, 1),
      likes: 0,
      views: 0,
    ),
    Post(
      title: '제목 3',
      content: '내용 3',
      id: 2,
      uploaderId: 2,
      created_at: DateTime(2024, 1, 1),
      likes: 0,
      views: 0,
    ),
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
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreatePostPage()),
            );
          },
          child: const Text('글쓰기'),
        ),
      ),
    );
  }
}
