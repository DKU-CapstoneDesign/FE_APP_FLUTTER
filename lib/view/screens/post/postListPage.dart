import 'package:capstonedesign/dataSource/post_dataSource.dart';
import 'package:capstonedesign/viewModel/post/postListPage_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:capstonedesign/view/screens/post/postDetailPage.dart';
import 'package:capstonedesign/view/screens/post/createPostPage.dart';
import 'package:provider/provider.dart';
import '../../../model/user.dart';

class PostListPage extends StatefulWidget {
  final String boardName;
  final User user; // 게시물 생성에 필요
  PostListPage({Key? key, required this.user, required this.boardName})
      : super(key: key);

  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {

  // viewModel의 게시글 리스트 가져오기
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<PostListViewModel>(context, listen: false);
      viewModel.getPostList(context);
      print('!!!!!${viewModel.posts}');
    });
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostListViewModel(PostDataSource()),
      child: Scaffold(
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
        body: Consumer<PostListViewModel>(
          builder: (context, viewModel, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.boardName == 'HOT게시판')
                      Container(
                        width: 350,
                        margin: EdgeInsets.only(bottom: 15.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          '좋아요 10개 이상인 게시물을 보여줘요!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    if (widget.boardName == '자유게시판')
                      Container(
                        width: 350,
                        margin: EdgeInsets.only(bottom: 15.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          '자유로운 주제에 대해 이야기해요!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    if (widget.boardName == '도움게시판')
                      Container(
                        width: 350,
                        margin: EdgeInsets.only(bottom: 15.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          '사람들에게 도움을 요청할 수 있어요!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    if (widget.boardName == '여행게시판')
                      Container(
                        width: 350,
                        margin: EdgeInsets.only(bottom: 15.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
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
                        itemCount: viewModel.posts.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 10);
                        },
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  viewModel.posts[index].title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(viewModel.posts[index].contents),
                                      ),
                                      Text(
                                        '좋아요 ${viewModel.posts[index].likeCount}개',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PostDetailPage(post: viewModel.posts[index]),
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
              );
            }
        ),
        floatingActionButton: widget.boardName != 'HOT게시판'
            ? FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreatePostPage(user: widget.user)),
            );
          },
          backgroundColor: Color.fromRGBO(92, 67, 239, 60),
          foregroundColor: Colors.white,
          label: Text('글쓰기'),
          icon: Icon(Icons.edit),
        )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}