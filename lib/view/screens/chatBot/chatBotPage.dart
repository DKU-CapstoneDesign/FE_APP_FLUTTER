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
      create: (context) => ChatBotViewModel(ChatBotDataSource()),
      child: Scaffold(
        backgroundColor: const Color(0xFFEDE7F6),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "챗봇 코리",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: 'SejonghospitalBold',
            ),
          ),
        ),
        body: Column(
          children: [
            // 메시지 리스트
            Expanded(
              child: Consumer<ChatBotViewModel>(
                builder: (context, viewModel, child) {
                  return ListView.builder(
                    reverse: false, // 최신 메시지를 아래에 표시
                    itemCount: viewModel.messages.length,
                    itemBuilder: (context, index) {
                      final message = viewModel.messages[index];
                      bool isUserMessage = message.isUserMessage;

                      return Align(
                        alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 챗봇 메시지일 때만 프로필 이미지와 이름 추가
                              if (!isUserMessage)
                                Row(
                                  children: [
                                    Image.asset('assets/img/chatBot.png', width: 35, height: 35),
                                    const SizedBox(width: 10),
                                    const Text(
                                      '코리 박사',
                                      style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontFamily: 'SejonghospitalBold',
                                    ),
                                    ),
                                  ],
                                ),
                              if (!isUserMessage) const SizedBox(height: 10),

                              Container(
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: isUserMessage
                                      ? const Color.fromRGBO(92, 67, 239, 1)
                                      : Colors.white,
                                  borderRadius: isUserMessage
                                      ? const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.zero, // Right side 뾰족하게
                                  )
                                      : const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.zero, // Left side 뾰족하게
                                  ),
                                ),
                                child: Text(
                                  message.text,
                                  style: TextStyle(
                                    color: isUserMessage ? Colors.white : Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // 메시지 입력 창
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              focusNode: _focusNode,
              decoration: const InputDecoration.collapsed(
                hintText: '메시지 입력...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final message = _textController.text.trim();
              if (message.isNotEmpty) {
                context.read<ChatBotViewModel>().sendMessage(message);
                _textController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}