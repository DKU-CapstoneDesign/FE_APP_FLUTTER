import 'package:capstonedesign/model/chatBot.dart';
import 'package:flutter/material.dart';
import '../../dataSource/chatBot_dataSource.dart';



class ChatBotViewModel extends ChangeNotifier {
  final ChatBotDataSource _dataSource;
  final List<Chatbot> _messages = [Chatbot(text: "안녕하세요 여러분의 한국 생활을 도와주는 챗봇 코리입니다! 궁금하신걸 뭐든지 물어봐주세요!", isUserMessage: false)];

  ChatBotViewModel(this._dataSource);

  List<Chatbot> get messages => List.unmodifiable(_messages);

  Future<void> sendMessage(String message) async {
    if (message.isNotEmpty) {
      _messages.add(Chatbot(text: message, isUserMessage: true));
      notifyListeners();

      try {
        final chatBotResponse = await _dataSource.getChatBotResponse(message);
        _messages.add(Chatbot(text: chatBotResponse, isUserMessage: false));
        notifyListeners();
      } catch (e) {
        // 에러 처리 로직 추가 가능
        _messages.add(Chatbot(text: "챗봇 응답을 가져오는 중 오류가 발생했습니다.", isUserMessage: false));
        notifyListeners();
      }
    }
  }
}