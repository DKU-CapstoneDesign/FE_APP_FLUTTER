import 'package:flutter/material.dart';
import '../../dataSource/chatting_dataSource.dart';
import '../../model/chattingList.dart';

class ChattingListViewModel extends ChangeNotifier {
  final ChattingDataSource datasource = ChattingDataSource();
  List<ChattingList> chatList = [];
  bool isLoading = true;
  ChattingListViewModel();

  Future<void> getChatList(String nickname) async {
    isLoading = true;
    notifyListeners();

    final chatStream = datasource.getChatList(nickname);
    await for (var chatListFromStream in chatStream) {
      if (chatListFromStream != null) {
        chatList = chatListFromStream;
        notifyListeners();
      }
    }
    isLoading = false;
    notifyListeners();
  }
}