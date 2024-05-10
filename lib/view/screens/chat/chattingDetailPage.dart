import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChattingDetailPage extends StatefulWidget {
  final String user;

  ChattingDetailPage({required this.user});

  @override
  _ChattingDetailPageState createState() => _ChattingDetailPageState();
}

class _ChattingDetailPageState extends State<ChattingDetailPage> {
  List<String> messages = [];

  final TextEditingController _messageController = TextEditingController();

  Future<void> _sendMessage(String message) async {
    final url = 'https://true-porpoise-uniformly.ngrok-free.app/api/chat';
    final Map<String, dynamic> data = {
      'sender': 'kyu',
      'receiver': 'bom',
      'message': message,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      setState(() {
        messages.add(message);
      });
      _messageController.clear();
    } else {
      // Handle error, show error message, etc.
      print('Failed to send message: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                String message = messages[index];
                bool isMyMessage = index % 2 == 0;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Align(
                    alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: isMyMessage ? Colors.purple : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        message,
                        style: TextStyle(color: isMyMessage ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String message = _messageController.text;
                    if (message.isNotEmpty) {
                      _sendMessage(message);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
