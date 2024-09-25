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
  Future<void> editPost(BuildContext context, int userId, int postId, User user) async {
    final editedPost = await datasource.editPost(
      title,
      contents,
      userId,
      postId,
      user
    );
    if (editedPost != null) {
      Navigator.pop(context, true);
    }
    notifyListeners();
  }
}