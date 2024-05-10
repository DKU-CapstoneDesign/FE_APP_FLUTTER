class Post {
  int id; // 게시글 ID
  int uploaderId; // 작성자 ID
  String title; // 제목
  String content; // 내용
  DateTime created_at; // 생성일자
  int likes; // 좋아요
  int views; // 조회수

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
//수정