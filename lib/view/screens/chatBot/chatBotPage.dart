import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:capstonedesign/model/message.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> _messages = [Message(text: "안녕하세요 여러분의 한국 생활을 도와주는 챗봇 코리입니다! 궁금하신걸 뭐든지 물어봐주세요!", isUserMessage: false)];

  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<String> _getChatBotResponse(String message) async {
    final url = Uri.parse('http://127.0.0.1:8080/chatbot/get-answer/');
    final headers = {'Content-Type' : 'application/json'};
    final body = jsonEncode({'query': message});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['answer'];
    } else {
      throw Exception("failed to get chatbot response");
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('챗봇 코리'),
      ),
      body: Column(
        children: [
          // 여기에 채팅 메시지 리스트를 추가하세요.
          Expanded(
            child: ListView.builder(
              // reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: message.isUserMessage
                        ? EdgeInsets.only(left: 96.0, top: 8.0, right: 8.0, bottom: 8.0)
                        : EdgeInsets.only(left: 8.0, top: 8.0, right: 96.0, bottom: 8.0),
                    decoration: BoxDecoration(
                      color: message.isUserMessage ? Colors.blue[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(_messages[index].text),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: '메시지 입력...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                GestureDetector(
                  onTap: _sendMessage,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    final message = _textController.text.trim();

    if (message.isNotEmpty) {
      setState(() {
        _messages.add(Message(text: message, isUserMessage: true));
      });
      // 여기에 메시지 전송 로직을 추가하세요.
      _textController.clear();

      final chatBotResponse = await _getChatBotResponse(message);
      setState(() {
        _messages.add(Message(text: chatBotResponse, isUserMessage: false));
      });
    }
  }

}