import 'package:capstonedesign/dataSource/post_dataSource.dart';
import 'package:flutter/cupertino.dart';

class PostListViewModel extends ChangeNotifier {
  final PostDataSource dataSource;
  List<dynamic> posts = [];
  bool isLoading = true;

  PostListViewModel(this.dataSource);

  // 게시물 목록 가져오기
  Future<void> getPostList(String boardName) async {
    switch (boardName) {
      case "자유게시판":
        boardName = "ANY";
        break;
      case "도움게시판":
        boardName = "HELPING";
        break;
      case "여행게시판":
        boardName = "TRAVELING";
        break;
    }
    isLoading = true;
    notifyListeners();

    List<dynamic>? allPosts = await dataSource.getAllPost();
    // boardName과 같은 category만 필터링
    posts = allPosts?.where((post) => post['category'] == boardName).toList() ?? [];
    isLoading = false; //데이터를 받아왔다면 로딩 끄기
    notifyListeners();
  }
}