import 'package:capstonedesign/model/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../dataSource/post_dataSource.dart';
import '../../dataSource/comment_dataSource.dart';
import '../../model/post.dart';
import '../../model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiscoverDetailViewModel extends ChangeNotifier {
  late Post post;
  final User user;
  final PostDataSource datasource;
  final CommentDatasource commentDatasource;
  final TextEditingController commentController = TextEditingController();

  DiscoverDetailViewModel(this.user, this.datasource, this.commentDatasource) {
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
      attachments: [],
    );
  }

  // 게시물 정보 가져오기
  Future<void> getPostInfo(int postId, User user) async {
    try {
      final postResponse = await datasource.getOnePost(postId, user);
      if (postResponse != null) {
        post = postResponse;
        notifyListeners();
      } else {
        print('게시물 조회에 실패했습니다.');
      }
    } catch (e) {
      print('에러 발생: $e');
    }
  }

  // 댓글 생성하기
  Future<void> createComment(int postId, int parentId) async {
    final newComment = await commentDatasource.createComment(commentController.text, postId, user, parentId);
    if (newComment != null) {
      post.commentList.add(newComment); // Add the new comment to the list
      commentController.clear();
      notifyListeners();
    }
  }

  // 댓글 보기
  Future<void> getComment(int postId) async {
    post.commentList = (await commentDatasource.getComment(postId, user)) as List<Comment>;
    notifyListeners();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}