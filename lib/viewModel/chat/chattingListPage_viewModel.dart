import 'package:flutter/material.dart';
import '../../dataSource/chatting_dataSource.dart';
import '../../model/chattingList.dart';

class ChattingListViewModel extends ChangeNotifier {
  final ChattingDataSource datasource = ChattingDataSource();
  List<ChattingList> chatList = [];
  bool loading = true;
  ChattingListViewModel();

  // 채팅방 리스트 가져오기 ---sse
  Future<void> getChatList(String nickname) async {
    final chatStream = datasource.getChatList(nickname);
    chatStream.listen((chatStream){
      chatList = chatStream!.cast<ChattingList>();
      loading = false;
      notifyListeners();
    });

  }
}