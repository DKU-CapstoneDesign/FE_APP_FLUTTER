import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/chat/chattingDetailPage_viewModel.dart';
import '../../../model/chatting.dart';

class ChattingDetailPage extends StatelessWidget {
  final String currentUserNickname; // sender
  final String otherUserNickname; // receiver

  ChattingDetailPage({
    required this.currentUserNickname,
    required this.otherUserNickname,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChattingDetailPageViewModel(currentUserNickname, otherUserNickname),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            otherUserNickname,
            style: const TextStyle(fontFamily: 'SejonghospitalBold', fontSize: 22),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(253, 247, 254, 1),
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
                    reverse: true, // 최신 메시지를 아래에 표시
                    itemCount: viewModel.messages.length,
                    itemBuilder: (context, index) {
                      final Chatting chatting = viewModel.messages[index];
                      bool isCurrentUser = chatting.sender == currentUserNickname;

                      return Align(
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
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


                //메시지 입력 창
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
                          viewModel.sendChat();
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