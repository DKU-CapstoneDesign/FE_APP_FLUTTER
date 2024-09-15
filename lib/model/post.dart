class Post {
  int id;
  String title;
  String contents;
  String nickname;
  DateTime createdAt;
  DateTime modifiedAt;
  int likeCount;
  List<String> commentList;

  Post({
    required this.id,
    required this.title,
    required this.contents,
    required this.nickname,
    required this.createdAt,
    required this.modifiedAt,
    required this.likeCount,
    required this.commentList,
  });

  // JSON으로부터 Post 객체 생성
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      contents: json['contents'] ?? '',
      nickname: json['nickname'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      modifiedAt: DateTime.parse(json['modifiedAt'] ?? DateTime.now().toIso8601String()),
      likeCount: json['likeCount'] ?? 0,
      commentList: List<String>.from(json['commentList'] ?? []),
    );
  }

  // Post 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'contents': contents,
      'nickname': nickname,
      'createdAt': createdAt.toIso8601String(), // DateTime을 문자열로 변환
      'modifiedAt': modifiedAt.toIso8601String(), // DateTime을 문자열로 변환
      'likeCount': likeCount,
      'commentList': commentList,
    };
  }
}