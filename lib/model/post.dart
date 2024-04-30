class Post {
  final int id; // 게시글 ID
  final int uploaderId; // 작성자 ID
  final String title; // 제목
  final String content; // 내용
  final DateTime created_at; // 생성일자
  final int likes; // 좋아요
  final int views; // 조회수

  Post({
    required this.id,
    required this.uploaderId,
    required this.title,
    required this.content,
    required this.created_at,
    required this.likes,
    required this.views,
  });
}
