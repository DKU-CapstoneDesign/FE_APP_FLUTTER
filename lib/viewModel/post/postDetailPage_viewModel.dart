import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../dataSource/post_dataSource.dart';
import '../../model/post.dart';

class PostDetailViewModel extends ChangeNotifier {
  late Post post;
  final PostDataSource datasource;
  bool isLiked = false;

  PostDetailViewModel(this.datasource) {
    post = Post(
      id: 0,
      userId: '',
      title: '',
      contents: '',
      category: '',
      nickname: '',
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
      likeCount: 0,
      viewCount: 0,
      commentList: [],
      attachments : [],
    );
  }

  // 게시물 정보 가져오기
  Future<void> getPostInfo(int postId) async {
    post = (await datasource.getOnePost(postId))!;
    notifyListeners();
  }

  // 좋아요 토글 로직
  void toggleLike() {
    if (isLiked) {
      post.likeCount--;
    } else {
      post.likeCount++;
    }
    isLiked = !isLiked;
    notifyListeners();
  }

}