import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';  // SharedPreferences 사용
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
  ChattingList? chattingList; // 초기화를 늦게 할 경우 nullable로 설정

  ChattingDetailPageViewModel(this.currentUserNickname, this.otherUserNickname) {
    _loadChattingListId(); // 로컬에서 채팅방 ID 불러오기
  }

  // 로컬 저장소에서 채팅방 ID 불러오기
  Future<void> _loadChattingListId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? chatId = prefs.getInt('chattingListId');
    if (chatId != null && chatId != 0) {
      // 채팅방이 있으면 기존 ID로 정보 로드
      chattingList = ChattingList(
        id: chatId,
        lastMessage: '',
        members: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await startChat(); // 기존 채팅방 로드
    } else {
      chattingList = ChattingList(
        id: 0,
        lastMessage: '',
        members: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      startChat(); // 새로운 채팅방 생성
    }
  }

  // 채팅방 생성 또는 로드
  Future<void> startChat() async {
    if (chattingList == null || chattingList!.id == 0) {
      // 채팅방이 없으면 새로 생성
      final result = await dataSource.createChat(currentUserNickname, otherUserNickname);
      if (result != null) {
        chattingList = result;
        // 생성된 채팅방 ID 로컬에 저장
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('chattingListId', chattingList!.id);
        notifyListeners();
      }
    } else {
      print("@@@@@@@@@${chattingList!.id}");
      // 채팅방이 있으면 기존 메시지 로드
      final messageStream = dataSource.chatListByRoomNum(chattingList!.id.toString());

      messageStream.listen((chatList) {
        print('Stream event: $chatList');
        if (chatList != null && chatList.isNotEmpty) {
          print('Messages retrieved: ${chatList.length}');
          messages = chatList.cast<Chatting>();
          notifyListeners();
        } else {
          print('No messages found.');
        }
      }, onError: (error) {
        print('Stream error: $error');
      }, onDone: () {
        print('Stream closed');
      });
    }
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

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}