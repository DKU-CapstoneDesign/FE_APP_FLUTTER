import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../dataSource/post_dataSource.dart';
import '../../model/post.dart';
import '../../model/user.dart';

class EditPostViewModel extends ChangeNotifier {
  String title = "", contents = "", category = "";
  List<Map<String, String>> attachments = [];
  late PostDataSource datasource;
  final Post post;
  final ImagePicker picker = ImagePicker();

  EditPostViewModel(this.datasource, this.post);

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

  // 게시물 수정하기
  Future<void> editPost(BuildContext context, String userId, int postId, User user) async {
    // 카테고리는 유지
    category = post.category;

    try {
      if (attachments.isEmpty) {
        // 첨부 파일이 없을 경우
        final editedPost = await datasource.editPost(
          title,
          contents,
          userId,
          postId,
          user,
          category,
        );

        if (editedPost != null) {
          Navigator.pop(context, true); // 성공적으로 수정된 경우
        } else {
          _showErrorDialog(context); // 실패 시 에러 다이얼로그 호출
        }
      } else {
        // 첨부 파일이 있을 경우
        final editedPostWithImage = await datasource.editPostWithImg(
          title,
          contents,
          userId,
          postId,
          user,
          category,
          attachments,
        );

        if (editedPostWithImage != null) {
          Navigator.pop(context, true); // 성공적으로 수정된 경우
        } else {
          _showErrorDialog(context); // 실패 시 에러 다이얼로그 호출
        }
      }
    } catch (e) {
      print("에러 발생: $e");
      _showErrorDialog(context);
    }
  }

  // 수정 실패 시 에러 다이얼로그
  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("글 수정에 실패하였습니다"),
          content: const Text("다시 시도해 주세요."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("확인"),
            ),
          ],
        );
      },
    );
  }
}