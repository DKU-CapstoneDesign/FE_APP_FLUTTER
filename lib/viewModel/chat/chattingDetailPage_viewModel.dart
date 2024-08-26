import 'package:flutter/material.dart';
import '../../model/chatting.dart';

class ChatViewModel extends ChangeNotifier {
  List<Chatting> _messages = [];

  List<Chatting> get messages => _messages;

  void addMessage(Chatting message) {
    _messages.add(message);
    notifyListeners();
  }
}
