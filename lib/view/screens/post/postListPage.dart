import 'package:capstonedesign/viewModel/post/postListPage_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:capstonedesign/view/screens/post/postDetailPage.dart';
import 'package:capstonedesign/view/screens/post/createPostPage.dart';
import 'package:provider/provider.dart';
import '../../../dataSource/post_dataSource.dart';
import '../../../model/user.dart';
import '../../../viewModel/post/postDetailPage_viewModel.dart';

class PostListPage extends StatefulWidget {
  final String boardName;
  final User user; // 게시물 생성에 필요
  PostListPage({Key? key, required this.user, required this.boardName})
      : super(key: key);

  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<PostListViewModel>(context, listen: false);
      await viewModel.getPostList();
    });
  }

  // 게시판 설명 메시지
  String _getBoardMessage(String boardName) {
    switch (boardName) {
      case 'HOT게시판':
        return '좋아요 10개 이상인 게시물을 보여줘요!';
      case '자유게시판':
        return '자유로운 주제에 대해 이야기해요!';
      case '도움게시판':
        return '사람들에게 도움을 요청할 수 있어요!';
      case '여행게시판':
        return '여행과 관련된 정보를 공유해요!';
      default:
        return '';
    }
  }

  // 새로고침 시 호출할 함수
  Future<void> _refreshPosts(BuildContext context) async {
    final viewModel = Provider.of<PostListViewModel>(context, listen: false);
    await viewModel.getPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            widget.boardName,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'SejonghospitalBold', fontSize: 22),
          ),
        ),
        centerTitle: true,
      ),
      //consumer를 이용한 상태 관리
      /*provider 대신 consumer를 사용한 이유??
        => 상태 관리를 더 명확하게 하고, 특정 위젯들만 다시 빌드할 수 있기 때문*/
      body: Consumer<PostListViewModel>(
        builder: (context, viewModel, child) {
          // 로딩 중이면 로딩 스피너를 표시
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          // 게시물이 없을 경우 처리
          if (viewModel.posts.isEmpty) {
            return Center(child: Text('게시물이 없습니다.'));
          }

          // 위로 당기면 새로고침할 수 있도록
          return RefreshIndicator(
            onRefresh: () => _refreshPosts(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    margin: EdgeInsets.only(bottom: 15.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      _getBoardMessage(widget.boardName),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      //여기서 viewModel은 위에 initState에서 선언
                      itemCount: viewModel.posts.length,
                      itemBuilder: (context, index) {
                        var post = viewModel.posts[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                post['title'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(post['contents']),
                                    ),
                                    Text(
                                      '좋아요 ${post['likeCount']}개',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChangeNotifierProvider(
                                      create: (_) => PostDetailViewModel(PostDataSource()),
                                      child: PostDetailPage(postId: post['id'], boardName: widget.boardName, currentUserNickname: widget.user.nickname,),
                                    ),
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
          );
        },
      ),
      //만약 HOT 게시판이면 글쓰기 버튼이 없도록
      floatingActionButton: widget.boardName != 'HOT게시판'
          ? FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePostPage(user: widget.user, boardName: widget.boardName,),
            ),
          );
          if (result == true) { //만약 새 글을 썼다면
            _refreshPosts(context); //화면 새로고침
          }
        },
        backgroundColor: Color.fromRGBO(92, 67, 239, 60),
        foregroundColor: Colors.white,
        label: Text('글쓰기'),
        icon: Icon(Icons.edit),
      )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}