import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capstonedesign/view/screens/chat/chattingDetailPage.dart';
import 'package:capstonedesign/view/widgets/infoBox.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import '../../../model/user.dart';
import '../../../viewModel/chat/chattingListPage_viewModel.dart';

class ChattingListPage extends StatefulWidget {
  final String currentUserNickname;
  final User user;
  ChattingListPage({Key? key, required this.currentUserNickname, required this.user})
      : super(key: key);

  @override
  _ChattingListPageState createState() => _ChattingListPageState();
}

// 시간 포맷
String _formatTime(DateTime dateTime) {
  return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
}

class _ChattingListPageState extends State<ChattingListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<ChattingListViewModel>(context, listen: false);
      await viewModel.getChatList(widget.currentUserNickname);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(92, 67, 239, 60),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          tr("chatting_title"),
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontFamily: 'SejonghospitalBold',
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            child: Infobox(
              tr("chatting_info_title"),
              tr("chatting_info_message"),
            ),
          ),
          const SizedBox(height: 35.0),
          Expanded(
            child: Consumer<ChattingListViewModel>(
              builder: (context, viewModel, child) {
                // 로딩
                if (viewModel.loading) {
                  return const Center(
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulseSync,
                        colors: [
                          Color.fromRGBO(92, 67, 239, 100),
                          Color.fromRGBO(92, 67, 239, 60),
                          Color.fromRGBO(92, 67, 239, 20),
                        ],
                      ),
                    ),
                  );
                }


                return viewModel.chatList.isEmpty
                    ?  Center(
                  child: Text(
                    tr("no_chat_room"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: viewModel.chatList.length,
                  itemBuilder: (context, index) {
                    final chat = viewModel.chatList[index];
                    final otherUserNickname = chat.members
                        .firstWhere((user) => user.nickname != widget.currentUserNickname)
                        .nickname;

                    return Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            // 채팅방으로 이동
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChattingDetailPage(
                                  currentUserNickname: widget.currentUserNickname,
                                  otherUserNickname: otherUserNickname,
                                  user: widget.user,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  child: Text(otherUserNickname[0]), // 유저 닉네임 첫 글자
                                ),
                                const SizedBox(width: 26.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        otherUserNickname,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        chat.lastMessage, // 마지막 메시지
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16.0,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Text(
                                  _formatTime(chat.updatedAt), // 마지막 시간
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}