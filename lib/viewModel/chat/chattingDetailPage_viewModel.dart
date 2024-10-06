import 'package:flutter/cupertino.dart';
import '../../dataSource/chatting_dataSource.dart';
import '../../model/chatting.dart';
import '../../model/chattingList.dart';
import '../../model/user.dart';

class ChattingDetailPageViewModel extends ChangeNotifier {
  List<Chatting> messages = [];
  late String currentUserNickname;
  late String otherUserNickname;
  final TextEditingController textController = TextEditingController();
  final ChattingDataSource dataSource = ChattingDataSource();
  ChattingList? chattingList;
  List<bool> messageReadStatus = []; //메시지 읽음 처리

  ChattingDetailPageViewModel(this.currentUserNickname, this.otherUserNickname) {
    startChat();
  }

  // 채팅방 생성
  Future<void> startChat() async {
    final result = await dataSource.createChat(currentUserNickname, otherUserNickname);
    if (result != null) {
      chattingList = result;
      //메시지 불러오기
      await fetchMessage();
    }
  }

  // 메시지 불러오기 ---sse
  Future<void> fetchMessage() async {
    final messageStream = dataSource.chatListByRoomNum(chattingList!.id.toString(),);
    messageStream.listen((chatList) {
      messages = chatList!.cast<Chatting>();
      notifyListeners();

    });
  }

  // 메시지 보내기
  Future<void> sendChat(User user) async {
    final messageText = textController.text;
    if (messageText.isEmpty) return;

    final newMessage = await dataSource.sendChat(currentUserNickname, otherUserNickname, messageText, user);
    if (newMessage != null) {
      messages.insert(0, newMessage);
      textController.clear();
      notifyListeners();
    }
  }

  //채팅방 읽음 처리
  Future<bool> setChatReadStatus()  async {
    final isRead = dataSource.setChatReadStatus(chattingList!.id.toString(), currentUserNickname); //receiver
    print(isRead);
    return isRead;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}