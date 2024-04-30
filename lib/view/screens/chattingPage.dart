import 'package:flutter/material.dart';
import '../view_models/chat_view_model.dart';

class ChatView extends StatelessWidget {
  final ChatViewModel viewModel;

  const ChatView({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: ListView.builder(
        itemCount: viewModel.messages.length,
        itemBuilder: (context, index) {
          final message = viewModel.messages[index];
          return ListTile(
            title: Text(message.sender),
            subtitle: Text(message.text),
          );
        },
      ),
    );
  }
}
