import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../dataSource/post_dataSource.dart';
import '../../model/user.dart';

class CreatePostViewModel extends ChangeNotifier {
  String title = "", contents = "", category = "";
  List<Map<String, String>> attachments = [];
  late PostDataSource datasource;
  final User user;
  final ImagePicker picker = ImagePicker();
  bool isPosting = false;

  CreatePostViewModel(this.datasource, this.user);

  // 여러 이미지 선택 로직
  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      attachments.add({
        'fileName': pickedFile.path.split('/').last,
        'filePath': pickedFile.path,
      });
      notifyListeners();
    }
  }

  // 이미지 선택 취소 로직
  void removeImage(int index) {
    if (attachments.isNotEmpty) {
      attachments.removeAt(index);
      notifyListeners();
    }
  }

  // 글 생성하기 로직 (form 데이터 형식으로 post)
  Future<void> createPost(BuildContext context) async {
    isPosting = true;
    // 카테고리 설정
    switch (category) {
      case "자유게시판":
        category = "ANY";
        break;
      case "도움게시판":
        category = "HELPING";
        break;
      case "여행게시판":
        category = "TRAVELING";
        break;
    }

    try {
      if (attachments.isEmpty) {
        // 첨부 파일이 없을 경우
        final newPost = await datasource.createPost(
          user.id.toString(),
          title,
          contents,
          category,
        );

        if (newPost != null) {
          Navigator.pop(context, true); // 이전 화면으로 돌아가면서 글이 생성되었음을 보냄
        } else {
          _showErrorDialog(context);
        }

      } else {
        // 첨부 파일이 있을 경우
        final newPostWithImage = await datasource.createPostWithImg(
          user.id.toString(),
          title,
          contents,
          category,
          attachments,
        );

        if (newPostWithImage != null) {
          Navigator.pop(context, true); // 이전 화면으로 돌아가면서 글이 생성되었음을 보냄
        } else {
          _showErrorDialog(context);
        }
      }
    } catch (e) {
      print("에러 발생: $e");
      _showErrorDialog(context);
    }
  }

  // 글 생성 실패 시 실패 다이얼로그 띄우기
  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("글 생성에 실패하셨습니다"),
          content: Text("확인 후 다시 시도하세요"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("확인"),
            ),
          ],
        );
      },
    );
  }
}