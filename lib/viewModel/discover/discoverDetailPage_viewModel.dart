import 'package:capstonedesign/dataSource/discover_dataSource.dart';
import 'package:capstonedesign/model/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../dataSource/post_dataSource.dart';
import '../../dataSource/comment_dataSource.dart';
import '../../model/post.dart';
import '../../model/user.dart';


class DiscoverDetailViewModel extends ChangeNotifier {
  final TextEditingController commentController = TextEditingController();
  late DiscoverDatasource datasource;

  // 축제 정보 가져오기
  Future<void> getPostInfo(int postId, User user) async {
    try {
      final postResponse = await datasource.getFestivals();
      if (postResponse != null) {

        notifyListeners();
      } else {
        print('게시물 조회에 실패했습니다.');
      }
    } catch (e) {
      print('에러 발생: $e');
    }
  }

}