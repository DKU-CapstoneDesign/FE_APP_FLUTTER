import 'package:capstonedesign/dataSource/post_dataSource.dart';
import 'package:flutter/cupertino.dart';

import '../../model/post.dart';


class PostListViewModel extends ChangeNotifier {
  final PostDataSource dataSource;
  List<dynamic> posts = [];
  bool isLoading = true; // 로딩 상태를 추가
  PostListViewModel(this.dataSource);

  //모든 게시물 가져오기
  Future<void> getPostList(BuildContext context) async {
    isLoading = true; // 로딩 시작
    notifyListeners();

    posts = await dataSource.getAllPost() ?? [];
    isLoading = false; // 로딩 완료
    notifyListeners();
  }

  // 게시물 추가하기
  Future<void> addPost(Post newPost) async {
    posts.insert(0, newPost); // 첫 번째 위치에 게시물 추가
    notifyListeners();
  }
}