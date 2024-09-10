import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post.dart';

class PostDataSource {
  String baseUrl = 'http://158.180.86.243:8080';

  /////게시글 생성
  Future<Post?> createPost(String title, String contents, int userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/post'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': title,
          'contents': contents,
          'userId': userId
        }),
      );
      if (response.statusCode == 200) {
        print("게시글 생성 성공");
        final Map<String, dynamic> responseData = json.decode(response.body);
        // Post 객체로 변환하여 반환
        return Post.fromJson(responseData);
      } else {
        print("게시글 생성 실패 : ${response.body}");
        return null;
      }
    } catch (e) {
      print('오류 발생: $e');
      return null;
    }
  }

  /////전체 게시글 조회
  Future<List?> getAllPost() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/posts'));

      if (response.statusCode == 200) {
        // 응답을 바이트로 변환한 후 UTF-8로 디코딩
        final decodedResponse = utf8.decode(response.bodyBytes);
        // 디코딩한 데이터를 JSON 파싱
        final Map<String, dynamic> responseData = json.decode(decodedResponse);

        if (responseData["success"] == true) {
          print("전체 게시글 조회 성공");

          // Post 객체 리스트로 반환
          final List<dynamic> postsData = responseData["response"];
          return postsData.cast<Map<String, dynamic>>();
        } else {
          print("전체 게시글 조회 실패");
          return null;
        }
      } else {
        print("전체 게시글 조회 실패");
        return null;
      }
    } catch (e) {
      print('에러 발생: $e');
      return null;
    }
  }

  /////선택된 게시글 조회
  Future<Post?> getOnePost(int postId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/post/$postId'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("게시글 조회 성공");
        // 선택된 게시글을 Post 객체로 반환
        return Post.fromJson(responseData);
      } else {
        print("게시글 조회 실패");
        return null;
      }
    } catch (e) {
      print('에러 발생: $e');
      return null;
    }
  }

  /////게시글 수정
  Future<bool> editPost(String title, String contents, int userId, int postId) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/post/$postId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': title,
          'contents': contents,
          'userId': userId
        }),
      );
      if (response.statusCode == 200) {
        print('게시글 수정 성공');
        return true;
      } else {
        print('게시글 수정 실패: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      print('에러 발생: $e');
      return false;
    }
  }

  /////게시글 삭제
  Future<bool> deletePost(int postId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/post/$postId'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print('게시글 삭제 성공');
        return true;
      } else {
        print('게시글 삭제 실패: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      print('에러 발생: $e');
      return false;
    }
  }
}