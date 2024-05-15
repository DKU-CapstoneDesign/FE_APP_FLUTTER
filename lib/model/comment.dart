class Comment {
  final int id; // 댓글 ID
  final int postId; // 게시글 ID
  final int writerId; // 작성자 ID
  final String text; // 내용

  Comment({
    required this.id,
    required this.postId,
    required this.writerId,
    required this.text,
  });
}
