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
  List<String> commentList;
  List<Map<String, String>>? attachments; //fileName, filePath

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

  // JSON으로부터 Post 객체 생성
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
      commentList: List<String>.from(json['commentList'] ?? []),
      attachments: List<Map<String, String>>.from(json['attachments'].map((attachment) => Map<String, String>.from(attachment))),
    );
  }

  // Post 객체를 JSON으로 변환
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
      'commentList': commentList,
      'attachments': attachments ?? [], // attachments가 null일 경우 빈 리스트
    };
  }
}