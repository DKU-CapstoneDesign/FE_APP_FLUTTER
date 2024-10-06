import 'comment.dart';

class Post {
  int id;
  int userId;
  String title;
  String contents;
  String category;
  String nickname;
  DateTime createdAt;
  DateTime modifiedAt;
  int likeCount;
  int viewCount;
  List<Comment> commentList;
  List<Map<String, String>>? attachments; // fileName, filePath

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.contents,
    required this.category,
    required this.nickname,
    required this.createdAt,
    required this.modifiedAt,
    required this.likeCount,
    required this.viewCount,
    required this.commentList,
    this.attachments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      title: json['title'] ?? '',
      contents: json['contents'] ?? '',
      category: json['category'] ?? '',
      nickname: json['nickname'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      modifiedAt: DateTime.parse(json['modifiedAt'] ?? DateTime.now().toIso8601String()),
      likeCount: json['likeCount'] ?? 0,
      viewCount: json['viewCount'] ?? 0,
      commentList: (json['commentList'] as List)
          .map((comment) => Comment.fromJson(comment))
          .toList(), // 댓글 리스트 처리
      attachments: List<Map<String, String>>.from(
          json['attachments']?.map((attachment) => Map<String, String>.from(attachment)) ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'contents': contents,
      'category': category,
      'nickname': nickname,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt.toIso8601String(),
      'likeCount': likeCount,
      'viewCount': viewCount,
      'commentList': commentList.map((comment) => comment.toJson()).toList(),
      'attachments': attachments ?? [], // attachments가 null일 경우 빈 리스트
    };
  }
}