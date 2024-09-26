import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/user.dart';
import '../../../viewModel/chat/chattingDetailPage_viewModel.dart';

class ChattingDetailPage extends StatefulWidget {
  final String currentUserNickname; // sender
  final String otherUserNickname; // receiver
  final User user;

  ChattingDetailPage({
    required this.currentUserNickname,
    required this.otherUserNickname,
    required this.user,
  });

  @override
  _ChattingDetailPageState createState() => _ChattingDetailPageState();
}

class _ChattingDetailPageState extends State<ChattingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChattingDetailPageViewModel>(
      create: (_) => ChattingDetailPageViewModel(
        widget.currentUserNickname,
        widget.otherUserNickname,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.otherUserNickname,
            style: const TextStyle(fontFamily: 'SejonghospitalBold', fontSize: 22),
          ),
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Consumer<ChattingDetailPageViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                // 메시지 리스트 표시
                Expanded(
                  child: ListView.builder(
                    reverse: false, // 최신 메시지를 아래에 표시
                    itemCount: viewModel.messages.length,
                    itemBuilder: (context, index) {
                      final chatting = viewModel.messages[index];
                      bool isCurrentUser = chatting.sender == widget.currentUserNickname;

                      return Align(
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10
                          ),
                          decoration: BoxDecoration(
                            color: isCurrentUser
                                ? const Color.fromRGBO(92, 67, 239, 20)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            chatting.message,
                            style: TextStyle(
                              color: isCurrentUser ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 메시지 입력 창
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                  color: const Color.fromRGBO(211, 211, 211, 40),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: viewModel.textController,
                          decoration: const InputDecoration.collapsed(
                            hintText: '메시지 입력...',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {

                          viewModel.sendChat(widget.user);

                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}