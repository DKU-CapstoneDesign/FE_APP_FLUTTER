import 'package:flutter/cupertino.dart';
import '../../dataSource/post_dataSource.dart';
import '../../model/post.dart';

class PostDetailViewModel extends ChangeNotifier {
  late Post post;
  final PostDataSource datasource;

  PostDetailViewModel(this.datasource) {
    post = Post(
        id: 0,
        title: '',
        contents: '',
        username: '',
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        likeCount: 0,
        commentList: []
    );
  }

  // 게시물 정보 가져오기
  Future<void> getPostInfo(int postId) async {
    post = (await datasource.getOnePost(postId))!;
    notifyListeners();
  }
}