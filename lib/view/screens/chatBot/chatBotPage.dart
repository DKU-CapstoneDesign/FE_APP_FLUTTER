import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../dataSource/chatBot_dataSource.dart';
import '../../../viewModel/chatBot/chatBotPage_viewModel.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatBotViewModel(ChatBotDataSource()), // ViewModel에 DataSource 주입
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('챗봇 코리'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<ChatBotViewModel>(
                builder: (context, viewModel, child) {
                  return ListView.builder(
                    itemCount: viewModel.messages.length,
                    itemBuilder: (context, index) {
                      final message = viewModel.messages[index];
                      return Align(
                        alignment: message.isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: message.isUserMessage
                              ? EdgeInsets.only(left: 96.0, top: 8.0, right: 8.0, bottom: 8.0)
                              : EdgeInsets.only(left: 8.0, top: 8.0, right: 96.0, bottom: 8.0),
                          decoration: BoxDecoration(
                            color: message.isUserMessage ? Colors.blue[200] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(message.text),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            ChatInputField(),
          ],
        ),
      ),
    );
  }
}

class ChatInputField extends StatefulWidget {
  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          GestureDetector(
            onTap: () {
              final message = _textController.text.trim();
              if (message.isNotEmpty) {
                context.read<ChatBotViewModel>().sendMessage(message);
                _textController.clear();
              }
            },
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
    );
  }
}