import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/comment.dart';
import '../model/post.dart';

class PostDataSource {
  String baseUrl = 'http://152.69.230.42:8080';
      //'http://152.69.230.42:8080';
      //'http://144.24.81.41:8080';
      // 'http://158.180.86.243:8080';

  ///////////게시글
  ////게시글 생성 (이미지 X)
  //form 데이터 형식으로 post
  Future<Post?> createPost(String userId, String title, String contents, String category) async {
    // 텍스트 필드만 전송하기 위한 데이터
    final formData = {
      'userId': userId,
      'title': title,
      'contents': contents,
      'category': category,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/post'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: formData,
      );

      if (response.statusCode == 200) {
        print("게시글 생성 성공");
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return Post.fromJson(responseData['response']);
        }
      } else {
        print('게시글 생성 실패:${response.body}');
        return null;
      }
    } catch (e) {
      print('에러 발생: $e');
      return null;
    }
  }
  ////게시글 생성 (이미지 O)
  //multipart/form-data로 텍스트와 파일을 함께 전송
  Future<Post?> createPostWithImg(String userId, String title, String contents, String category, List<Map<String, String>> attachments) async {
    var uri = Uri.parse('$baseUrl/api/post');
    // JSON 형식으로 서버에서 요구하는 파일 정보와 함께 텍스트 데이터를 포함
    Map<String, dynamic> data = {
      'userId': userId,
      'title': title,
      'contents': contents,
      'category': category,
      'attachments': attachments,
    };

    try {
      // POST 요청 전송
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json', // JSON 형식으로 전송
        },
        body: json.encode(data), // 데이터를 JSON으로 인코딩
      );

      if (response.statusCode == 200) {
        print("게시글 생성 성공");

        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return Post.fromJson(responseData['response']);
        }
      } else {
        print('게시글 생성 실패: ${response.body}');
        return null;
      }
    } catch (e) {
      print('에러 발생: $e');
      return null;
    }
  }

  ////전체 게시글 조회
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

  ////선택된 게시글 조회
  Future<Post?> getOnePost(int postId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/post/$postId'));
      if (response.statusCode == 200) {
        // 응답을 바이트로 변환한 후 UTF-8로 디코딩
        final decodedResponse = utf8.decode(response.bodyBytes);
        // 디코딩한 데이터를 JSON 파싱
        final Map<String, dynamic> responseData = json.decode(decodedResponse);
        if (responseData["success"] == true) {
          print("게시글 조회 성공");

          Map<String, dynamic> clickedPost = responseData["response"];
          print(clickedPost);
          // Post 객체 리스트로 반환
          return Post.fromJson(clickedPost);
        }
      } else {
        print("게시글 조회 실패");
        return null;
      }
    } catch (e) {
      print('에러 발생: $e');
      return null;
    }
  }


  ////게시글 수정
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

  ////게시글 삭제
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



  ///////////댓글
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

  ///////////좋아요 누르기
  //form 데이터 형식으로 post
  Future<Post?> pushLike(String postId, String userId, String title, String contents, String category, String attachments) async {
    final formData = {
      'userId': userId,
      'title': title,
      'contents': contents,
      'category': category,
      'attachments': attachments,
    };
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/post/$postId/likes'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: formData,
      );

      if (response.statusCode == 200) {
        print("좋아요 누르기 성공");
        //model의 Post에 값을 넣기
        return Post.fromJson(json.decode(response.body));
      } else {
        print("좋아요 누르기 실패 : ${response.body}");
        return null;
      }
    } catch (e) {
      print('오류 발생: $e');
      return null;
    }
  }


}