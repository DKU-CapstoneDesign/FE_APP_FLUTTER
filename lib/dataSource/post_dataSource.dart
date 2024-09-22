import 'dart:convert';
import 'package:capstonedesign/model/user.dart';
import 'package:http/http.dart' as http;
import '../model/post.dart';

class PostDataSource {
  String baseUrl = 'http://152.69.230.42:8080';
      //'http://152.69.230.42:8080';
      //'http://144.24.81.41:8080';
      // 'http://158.180.86.243:8080';


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

    var request = http.MultipartRequest('POST', uri)
      ..fields['userId'] = userId
      ..fields['title'] = title
      ..fields['contents'] = contents
      ..fields['category'] = category;

    for (var attachment in attachments) {
      request.files.add(await http.MultipartFile.fromPath(
        'attachments',
        attachment['filePath']!,
        filename: attachment['fileName'],
      ));
    }

    try {
      // 서버로 전송
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

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
  Future<Post?> getOnePost(int postId, User user) async {
    print(user.cookie);
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/post/$postId'),
        headers: {
          'Cookie': user.cookie,
        },
      );

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
        print("게시글 조회 실패: ${response.statusCode}, 응답 본문: ${response.body}");
        return null;
      }
    } catch (e) {
      print('에러 발생: $e');
      return null;
    }
  }


  ////게시글 수정
  Future<Post?> editPost(String title, String contents, int userId, int postId, User user) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/post/$postId'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': user.cookie
        },
        body: jsonEncode({
          'title': title,
          'contents': contents,
          'userId': userId
        })
      );

      print('응답 상태 코드: ${response.statusCode}');
      print('응답 본문: ${response.body}');

      if (response.statusCode == 200) {
        print("게시글 수정 성공");
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          return Post.fromJson(responseData['response']);
        }
      } else {
        print('게시글 수정 실패: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('에러 발생: $e');
      return null;
    }
  }

  ////게시글 삭제
  Future<bool> deletePost(int postId, User user) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/post/$postId'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': user.cookie
        },
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

  ///////////좋아요 누르기
  //form 데이터 형식으로 post
  Future<bool> pushLike(String postId, String userId, String title, String contents, String category) async {
    final formData = {
      'userId': userId,
      'title': title,
      'contents': contents,
      'category': category,
    };
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/post/$postId/likes'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: formData,
      );

      if (response.statusCode == 200) {
        print("좋아요 누르기 성공");
        return true;
      } else {
        print("좋아요 누르기 실패 : ${response.body}");
        return false;
      }
    } catch (e) {
      print('오류 발생: $e');
      return false;
    }
  }
}