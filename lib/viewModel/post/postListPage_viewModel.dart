import 'package:capstonedesign/dataSource/post_dataSource.dart';
import 'package:capstonedesign/model/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PostListViewModel extends ChangeNotifier{
  late PostDataSource datasource;
  List<dynamic> posts = [];
  PostListViewModel(this.datasource);


  //리턴 받은 post들을 리스트에 넣기
  Future<void> getPostList(BuildContext context) async{
    posts = (await datasource.getAllPost()) ?? [];
    print('!!!!!${posts}');
    notifyListeners();
  }

}