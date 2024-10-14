import 'dart:convert';

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
  void initState() {
    super.initState();

    // 읽음 처리는 추후 구현
   /* WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChattingDetailPageViewModel>(context, listen: false)
          .setChatReadStatus();
    });*/
  }

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
                      // 읽음 처리는 추후 구현
                      //bool isRead = viewModel.setChatReadStatus() as bool;


                      return Align(
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              // 읽음 처리는 추후 구현
                             /* // 상대방이 읽지 않으면 메시지 옆에 1이 뜨도록
                              if (isCurrentUser && isRead==false)
                                const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Text(
                                      '1',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black
                                      ),
                                    ),
                                  ),
*/
                              Container(
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: isCurrentUser
                                      ? const Color.fromRGBO(92, 67, 239, 1)
                                      : Colors.grey[300],
                                  borderRadius: isCurrentUser
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
                                  chatting.message,
                                  style: TextStyle(
                                    color: isCurrentUser ? Colors.white : Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 메시지 입력 창
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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