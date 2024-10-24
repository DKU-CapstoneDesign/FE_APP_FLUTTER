import 'package:capstonedesign/dataSource/comment_dataSource.dart';
import 'package:capstonedesign/viewModel/post/postListPage_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:capstonedesign/view/screens/post/postDetailPage.dart';
import 'package:capstonedesign/view/screens/post/createPostPage.dart';
import 'package:loading_indicator/loading_indicator.dart';
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
      await viewModel.getPostList(widget.user, widget.boardName);
    });
  }

  // 게시판 설명 메시지
  String _getBoardMessage(String boardName) {
    switch (boardName) {
      case '최신게시판':
        return '가장 최신 글만 모아모아';
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
    await viewModel.getPostList(widget.user, widget.boardName);
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
            style: const TextStyle(fontFamily: 'SejonghospitalBold', fontSize: 22),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 350,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                _getBoardMessage(widget.boardName),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<PostListViewModel>(
              builder: (context, viewModel, child) {
                // 데이터 받아올 때까지 로딩 화면
                if (viewModel.isLoading) {
                  return const Center(
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulseSync,
                        colors: [
                          Color.fromRGBO(92, 67, 239, 100),
                          Color.fromRGBO(92, 67, 239, 60),
                          Color.fromRGBO(92, 67, 239, 20),
                        ],
                      ),
                    ),
                  );
                }

                // 게시물이 없을 경우 처리
                if (viewModel.posts.isEmpty) {
                  return const Center(
                    child: Text('게시물이 없습니다.'),
                  );
                }

                // 위로 당기면 새로고침할 수 있도록
                return RefreshIndicator(
                  onRefresh: () => _refreshPosts(context),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    itemCount: viewModel.posts.length,
                    itemBuilder: (context, index) {
                      var post = viewModel.posts[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              post['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SejonghospitalBold',
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      post['contents'],
                                      style: const TextStyle(
                                        fontFamily: 'Sejonghospital',
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '좋아요 ${post['likeCount']}개',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'SejonghospitalLight',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                    create: (_) => PostDetailViewModel(
                                      PostDataSource(),
                                      widget.user,
                                      CommentDatasource(),
                                    ),
                                    child: PostDetailPage(
                                      postId: post['id'],
                                      boardName: widget.boardName,
                                      currentUserNickname: widget.user.nickname,
                                      user: widget.user,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10),

                          Divider(
                            color: Colors.grey[300],
                            height: 1,
                            thickness: 1,
                          ),

                          SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: widget.boardName != '최신게시판'
          ? FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePostPage(
                user: widget.user,
                boardName: widget.boardName,
              ),
            ),
          );
          if (result == true) {
            _refreshPosts(context); // 새 글을 썼다면 화면 새로고침
          }
        },
        backgroundColor: const Color.fromRGBO(92, 67, 239, 60),
        foregroundColor: Colors.white,
        label: const Text('글쓰기'),
        icon: const Icon(Icons.edit),
      )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}