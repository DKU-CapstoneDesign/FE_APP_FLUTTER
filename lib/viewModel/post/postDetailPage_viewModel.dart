import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../dataSource/post_dataSource.dart';
import '../../model/post.dart';
import '../../model/user.dart';

class PostDetailViewModel extends ChangeNotifier {
  late Post post;
  final PostDataSource datasource;
  bool isLiked = false;
  bool isDeleted = false;

  PostDetailViewModel(this.datasource) {
    post = Post(
      id: 0,
      userId: 0,
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
  Future<void> getPostInfo(int postId, User user) async {
    post = (await datasource.getOnePost(postId, user))!;
    notifyListeners();
  }

  // 게시물 삭제하기
  Future<void> deletePost() async {
    isDeleted = (await datasource.deletePost(post.id));
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