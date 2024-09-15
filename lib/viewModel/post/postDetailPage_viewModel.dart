import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../dataSource/post_dataSource.dart';
import '../../model/post.dart';
import '../../dataSource/chatting_dataSource.dart';
import '../../view/screens/chat/chattingDetailPage.dart';

class PostDetailViewModel extends ChangeNotifier {
  late Post post;
  final PostDataSource datasource;
  bool isLiked = false;

  PostDetailViewModel(this.datasource) {
    post = Post(
      id: 0,
      title: '',
      contents: '',
      nickname: '',
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
      likeCount: 0,
      commentList: [],
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