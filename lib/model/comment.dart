class Comment {
  String contents;
  String parentCommentId;

  Comment({
    required this.contents,
    required this.parentCommentId,
  });

  // JSON으로부터 Comment 객체 생성
  factory Comment.fromJson(Map<String, dynamic> json){
    return Comment(
        contents: json['contents'] ?? '',
        parentCommentId: json['parentCommentId'] ?? ''
    );
  }

 // Comment 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'contents' :contents,
      'parentCommentId' : parentCommentId
    };
  }
}
