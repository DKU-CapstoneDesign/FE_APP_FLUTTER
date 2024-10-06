class Comment {
  int id;
  String contents;
  String nickname;
  DateTime createdAt;
  DateTime modifiedAt;
  int likeCount;
  List<Comment> childCommentList; // 대댓글 리스트

  Comment({
    required this.id,
    required this.contents,
    required this.nickname,
    required this.createdAt,
    required this.modifiedAt,
    required this.likeCount,
    required this.childCommentList,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      contents: json['contents'],
      nickname: json['nickname'],
      createdAt: DateTime.parse(json['createdAt']),
      modifiedAt: DateTime.parse(json['modifiedAt']),
      likeCount: json['likeCount'],
      childCommentList: (json['childCommentList'] as List)
          .map((childComment) => Comment.fromJson(childComment))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contents': contents,
      'nickname': nickname,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt.toIso8601String(),
      'likeCount': likeCount,
      'childCommentList': childCommentList.map((comment) => comment.toJson()).toList(),
    };
  }
}