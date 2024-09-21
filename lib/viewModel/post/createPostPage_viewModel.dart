import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../dataSource/post_dataSource.dart';
import '../../model/user.dart';

class CreatePostViewModel extends ChangeNotifier {
  late String title, contents, category;
  List<Map<String, String>>? attachments = []; // 여러 개의 파일을 담는 리스트
  late PostDataSource datasource;
  final User user;
  final ImagePicker picker = ImagePicker();

  CreatePostViewModel(this.datasource, this.user);

  // 여러 이미지 선택 로직 (현재 image_picker는 여러 파일 선택을 지원하지 않으므로 반복 선택으로 처리)
  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // 각 이미지 파일의 fileName과 filePath를 저장
      attachments!.add({
        'fileName': pickedFile.path.split('/').last,
        'filePath': pickedFile.path,
      });
    }
    notifyListeners();
  }

  // 이미지 선택 취소 로직
  void removeImage(int index) {
    if (attachments != null && attachments!.isNotEmpty) {
      attachments!.removeAt(index); // 해당 인덱스의 이미지를 삭제
    }
    notifyListeners();
  }

  // 글 생성하기 로직 (form 데이터 형식으로 post)
  Future<void> createPost(BuildContext context) async {
    if(category =="자유게시판"){
      category = "ANY";
    }else if(category == "도움게시판"){
      category = "HELPING";
    } else if(category == "여행게시판"){
      category =  "TRAVELING";
    }

    // 첨부 파일이 없을 경우
    if (attachments == null || attachments!.isEmpty) {
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

      // 첨부 파일이 있을 경우
    } else {
      final newPostWithImage = await datasource.createPostWithImg(
        user.id.toString(),
        title,
        contents,
        category,
        attachments!, // 첨부된 이미지 리스트 전달
      );
      if (newPostWithImage != null) {
        Navigator.pop(context, true); // 이전 화면으로 돌아가면서 글이 생성되었음을 보냄
      } else {
        _showErrorDialog(context);
      }
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