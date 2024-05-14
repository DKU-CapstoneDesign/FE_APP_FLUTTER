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
      likes: 5,
      views: 0,
    ),
    Post(
      title: '제목 2',
      content: '내용 2',
      id: 1,
      uploaderId: 1,
      created_at: DateTime(2024, 1, 1),
      likes: 10,
      views: 0,
    ),
    Post(
      title: '제목 3',
      content: '내용 3',
      id: 2,
      uploaderId: 2,
      created_at: DateTime(2024, 1, 1),
      likes: 3,
      views: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            boardName,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (boardName == '🔥 HOT 게시물')
              Container(
                width: 350,
                margin: EdgeInsets.only(bottom: 15.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  '좋아요 10개 이상인 게시물을 보여줘요!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            if (boardName == '자유 게시판')
              Container(
                width: 350,
                margin: EdgeInsets.only(bottom: 15.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  '자유로운 주제에 대해 이야기해요!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            if (boardName == '도움 게시판')
              Container(
                width: 350,
                margin: EdgeInsets.only(bottom: 15.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  '사람들에게 도움을 요청할 수 있어요!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            if (boardName == '여행 게시판')
              Container(
                width: 350,
                margin: EdgeInsets.only(bottom: 15.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  '여행과 관련된 정보를 공유해요!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            Expanded(
              child: ListView.separated(
                itemCount: posts.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          posts[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(posts[index].content),
                              ),
                              Text(
                                '좋아요 ${posts[index].likes}개',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PostDetailPage(post: posts[index]),
                            ),
                          );
                        },
                      ),
                      Divider(
                        color: Colors.grey[300],
                        height: 1,
                        thickness: 1,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostPage()),
          );
        },
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        label: Text('글쓰기'),
        icon: Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
