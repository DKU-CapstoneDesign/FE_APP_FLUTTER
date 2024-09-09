import 'package:capstonedesign/dataSource/post_dataSource.dart';
import 'package:flutter/cupertino.dart';


class PostListViewModel extends ChangeNotifier {
  final PostDataSource dataSource;
  List<dynamic> posts = [];
  bool isLoading = true; // 로딩 상태를 추가

  PostListViewModel(this.dataSource);

  Future<void> getPostList(BuildContext context) async {
    isLoading = true; // 로딩 시작
    notifyListeners();

    posts = await dataSource.getAllPost() ?? [];
    isLoading = false; // 로딩 완료
    notifyListeners();
  }
}