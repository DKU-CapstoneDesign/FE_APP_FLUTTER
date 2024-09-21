import 'package:http/http.dart' as http;
import '../model/comment.dart';
import 'dart:convert';

class CommentDatasource{
  String baseUrl = 'http://152.69.230.42:8080';

  ////댓글 생성
  Future<Comment?> createComment(String comment, int id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/comment/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'comment': comment,
          'parentCommentId' :'',
        }),
      );
      if (response.statusCode == 200) {
        print("댓글 생성 성공");
        final Map<String, dynamic> responseData = json.decode(response.body);
        // Post 객체로 변환하여 반환
        return Comment.fromJson(responseData);
      } else {
        print("댓글 생성 실패 : ${response.body}");
        return null;
      }
    } catch (e) {
      print('오류 발생: $e');
      return null;
    }
  }

   ////댓글 조회
  Future<Comment?> getComment(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/comment/$id'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("댓글 조회 성공");
        return Comment.fromJson(responseData);
      } else {
        print("댓글 조회 실패");
        return null;
      }
    } catch (e) {
      print('에러 발생: $e');
      return null;
    }
  }

  ////댓글 삭제
  Future<bool> deleteComment(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/comment/$id'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print('댓글 삭제 성공');
        return true;
      } else {
        print('댓글 삭제 실패: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      print('에러 발생: $e');
      return false;
    }
  }
}
