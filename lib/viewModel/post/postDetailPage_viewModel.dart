import 'package:capstonedesign/dataSource/comment_dataSource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../dataSource/post_dataSource.dart';
import '../../model/post.dart';
import '../../model/user.dart';

class PostDetailViewModel extends ChangeNotifier {
  late Post post;
  final User user;
  String comment = '';
  final PostDataSource datasource;
  final CommentDatasource commentDatasource;
  bool isLiked = false;
  bool isDeleted = false;

  PostDetailViewModel(this.datasource, this.user, this.commentDatasource) {
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
  Future<void> deletePost(BuildContext context, int postId, User user) async {
    isDeleted = (await datasource.deletePost(postId,user))!;
    if (isDeleted) {
      Navigator.pop(context, true);
    }
    notifyListeners();
  }

  // 좋아요 토글 로직
  Future<void> pushLike (int postId, int userId) async{
    isLiked = await datasource.pushLike(
      postId.toString(),
      userId.toString(),
      post.title,
      post.contents,
      post.category
    );
    if(isLiked){
      post.likeCount++;
    }
    notifyListeners();
  }


  // 댓글 생성하기
  Future<void> createComment(int postId) async{
    final newComment = await commentDatasource.createComment(comment, postId);

    if (newComment != null) {
      post.commentList.add(newComment as String);
      notifyListeners();
    }
  }

  // 댓글 삭제하기

}