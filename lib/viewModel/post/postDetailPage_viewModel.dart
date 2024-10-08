import 'package:capstonedesign/dataSource/comment_dataSource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../dataSource/post_dataSource.dart';
import '../../model/post.dart';
import '../../model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostDetailViewModel extends ChangeNotifier {
  late Post post;
  final User user;
  final PostDataSource datasource;
  final CommentDatasource commentDatasource;
  bool isLiked = false;
  bool isDeleted = false;
  final TextEditingController commentController = TextEditingController();

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
      attachments: [],
    );
  }

  ///////// 게시물
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

  // 게시물 삭제하기
  Future<void> deletePost(BuildContext context, int postId, User user) async {
    isDeleted = (await datasource.deletePost(postId, user))!;
    if (isDeleted) {
      Navigator.pop(context, true);
    }
    notifyListeners();
  }


  ////// 좋아요 로직

  //사용자가 좋아요 했는지 로컬에서 저장( shared_preferences 사용 )
  Future<void> saveLikeLocally(int postId, int userId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('liked_${postId}_$userId', true);
  }
  //사용자가 좋아요 했는지 로컬에서 확인( shared_preferences 사용 )
  Future<bool> hasLikedLocally(int postId, int userId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('liked_${postId}_$userId') ?? false;
  }

  Future<void> toggleLike(int postId, int userId, User user) async {
    // 로컬에서 이미 좋아요를 눌렀는지 확인
    bool hasLiked = await hasLikedLocally(postId, userId);

    if (hasLiked) {
      return; //이미 눌렀으면 함수 나가기
    }

    bool success = await datasource.pushLike(
      postId.toString(),
      userId.toString(),
      post.title,
      post.contents,
      post.category,
      user,
    );

    if (success) {
      isLiked = !isLiked;
      post.likeCount = isLiked ? post.likeCount + 1 : post.likeCount - 1;

      // 로컬에 저장
      await saveLikeLocally(postId, userId);

      notifyListeners();
    }
  }

  ///////// 댓글
  // 댓글 생성하기
  Future<void> createComment(int postId, int parentId) async {
    final newComment = await commentDatasource.createComment(
        commentController.text, postId, user, parentId
    );
    if (newComment != null) {
      commentController.clear();
      notifyListeners();
    }
  }

  // 댓글 보기
  Future<void> getComment(int postId) async {
    await commentDatasource.getComment(postId, user);
  }

  // 댓글 삭제하기
  Future<void> deleteComment(int commentId) async {
    await commentDatasource.deleteComment(commentId, user);
    notifyListeners();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}