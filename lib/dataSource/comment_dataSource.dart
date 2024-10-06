import 'package:http/http.dart' as http;
import '../model/comment.dart';
import 'dart:convert';

import '../model/user.dart';

class CommentDatasource{
  String baseUrl = 'http://152.69.230.42:8080';

  //// 댓글 생성
  Future<Comment?> createComment(String comment, int postId, User user, int parentCommentId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/comment/$postId'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': user.cookie
        },
        body: jsonEncode({
          'contents': comment,
          'parentCommentId': parentCommentId == 0 ? null : parentCommentId,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if(responseData['success'] == true){
          print("댓글 생성 성공");
          return Comment.fromJson(responseData['response']);
        }
      } else {
        print("댓글 생성 실패 : ${response.body}");
        return null;
      }
    } catch (e) {
      print('오류 발생: $e');
      return null;
    }
  }


  //// 댓글 조회
  Future<Comment?> getComment(int postId, User user) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/comment/$postId'),
        headers: {
          'Cookie': user.cookie
        },
      );
      if (response.statusCode == 200) {
        // 응답을 바이트로 변환한 후 UTF-8로 디코딩
        final decodedResponse = utf8.decode(response.bodyBytes);
        // 디코딩한 데이터를 JSON 파싱
        final responseData = json.decode(decodedResponse);
        if (responseData["success"] == true) {
          print("댓글 조회 성공");
          return Comment.fromJson(responseData['response']);
        }
      } else {
        print("댓글 조회 실패 : ${response.body}");
        return null;
      }
    } catch (e) {
      print('오류 발생: $e');
      return null;
    }
  }



  ////댓글 삭제
  Future<bool> deleteComment(int id, User user) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/comment/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': user.cookie
        },
      );
      if (response.statusCode == 200) {
        print('댓글 삭제 성공');
        return true;
      } else {
        print('댓글 삭제 실패: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      print('오류 발생: $e');
      return false;
    }
  }
}
