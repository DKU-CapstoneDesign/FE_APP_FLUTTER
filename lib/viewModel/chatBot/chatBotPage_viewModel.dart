import 'package:capstonedesign/model/chatBot.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../dataSource/chatBot_dataSource.dart';

class ChatBotViewModel extends ChangeNotifier {
  final ChatBotDataSource _dataSource;
  final List<Chatbot> _messages = [
    Chatbot(
        text: tr("welcome_message"),
        isUserMessage: false
    )
  ];

  ChatBotViewModel(this._dataSource);

  List<Chatbot> get messages => List.unmodifiable(_messages);

  // 챗봇에게 메시지 보내기
  Future<void> sendMessage(String message) async {
    if (message.isNotEmpty) {
      _messages.add(Chatbot(text: message, isUserMessage: true));
      notifyListeners();

      try {
        final chatBotResponse = await _dataSource.getChatBotResponse(message);
        _messages.add(Chatbot(text: chatBotResponse ??
            tr("error_message"), isUserMessage: false));
        notifyListeners();
      } catch (e) {
        _messages.add(Chatbot(text: tr("error_message"), isUserMessage: false));
        notifyListeners();
      }
    }
  }
}