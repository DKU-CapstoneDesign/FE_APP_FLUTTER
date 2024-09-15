import 'package:flutter/material.dart';
import '../../dataSource/chatting_dataSource.dart';
import '../../model/chattingList.dart';


class ChattingListViewModel extends ChangeNotifier {
  final ChattingDataSource datasource;
  List<ChattingList> _chatList = [];
  bool _isLoading = true;

  ChattingListViewModel(this.datasource);

  List<ChattingList> get chatList => _chatList;
  bool get isLoading => _isLoading;

  Future<void> getChatList(String nickname) async {
    _isLoading = true;
    notifyListeners(); // 로딩 시작 알림

    final result = await datasource.getChatList(nickname);
    if (result != null) {
      _chatList = result;
    }
    _isLoading = false;
    notifyListeners(); // 데이터 가져오기 완료 알림
  }
}