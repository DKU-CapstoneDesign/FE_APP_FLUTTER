import 'package:capstonedesign/dataSource/post_dataSource.dart';
import 'package:flutter/cupertino.dart';

class PostListViewModel extends ChangeNotifier {
  final PostDataSource dataSource;
  List<dynamic> posts = [];
  bool isLoading = true;

  PostListViewModel(this.dataSource);

  // 게시물 목록 가져오기
  Future<void> getPostList() async {
    isLoading = true;
    notifyListeners();

    posts = (await dataSource.getAllPost()) ?? [];
    isLoading = false; //데이터를 받아왔다면 로딩 끄기
    notifyListeners();
  }
}