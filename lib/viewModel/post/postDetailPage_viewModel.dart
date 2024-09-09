import 'package:flutter/cupertino.dart';
import '../../dataSource/post_dataSource.dart';

class  PostDetailViewModel extends ChangeNotifier{
  late String title, contents, username;
  late DateTime createdAt, modifiedAt;
  late int likeCount;
  late List<String> commentList;
  late PostDataSource datasource;
  PostDetailViewModel(this.datasource);

  //댓글 달기 로직
  Future<void> addComment(BuildContext context) async{

  }

}