import 'package:flutter/cupertino.dart';

import '../../dataSource/chatting_dataSource.dart';
import '../../model/chatting.dart';

class ChattingDetailPageViewModel extends ChangeNotifier {
  final List<Chatting> messages = [];
  late String currentUserNickname;
  late String otherUserNickname;
  final TextEditingController textController = TextEditingController();
  final ChattingDataSource dataSource = ChattingDataSource();
  late String roomNum;

  ChattingDetailPageViewModel(this.currentUserNickname, this.otherUserNickname) {
    // 채팅방 생성 혹은 이전 채팅 내용 가져오기
    startChat();
  }

  // 채팅방이 있다면 -> 이전 채팅 내용 가져오기 (chatListByRoomNum)
  // 채팅방이 없다면 -> 채팅방 생성하기 (createChat)
  Future<void> startChat() async {
    final chatRoom = await dataSource.createChat(currentUserNickname, otherUserNickname);

    /*if (chatRoom != null) {
      roomNum = chatRoom.id.toString();
      final messages = await dataSource.chatListByRoomNum(roomNum);
      if (messages != null && messages.isNotEmpty) {
        _messages = messages.map((msg) => Chatting.fromJson(msg as Map<String, dynamic>)).toList();
        notifyListeners(); // UI 업데이트
      }*/
    //}
  }

  // 메시지 보내기
  Future<void> sendChat() async {
    final messageText = textController.text;
    if (messageText.isEmpty) return;
    final newMessage = await dataSource.sendChat(currentUserNickname, otherUserNickname, messageText);

    if(newMessage !=null){
      messages.insert(0, newMessage);
      textController.clear();
      notifyListeners();
    }
  }


  // TextEditingController 해제!
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}