import 'package:flutter/material.dart';
import '../../dataSource/post_dataSource.dart';
import '../../model/user.dart';

class CreatePostViewModel extends ChangeNotifier {
  late String title, contents;
  late PostDataSource datasource;
  late BuildContext context;
  final User user;
  // File? imageFile;
  CreatePostViewModel(this.datasource, this.user);


  //글 생성하기 로직
  Future<void> createPost(BuildContext context) async {
    final newPost = await datasource.createPost(title, contents, user.id);
    if (newPost != null) { //만약 데이터를 전송 받았다면
      Navigator.pop(context, newPost); // 이전 화면으로 돌아가면서 새로운 게시물 반환
    } else {
      _showErrorDialog(context);
    }
  }
  //글 생성 실패 시 실패 다이얼로그 띄우기
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