import 'package:flutter/material.dart';
import 'package:capstonedesign/view/screens/chat/chattingDetailPage.dart';

class ChattingListPage extends StatefulWidget {
  @override
  _ChattingListPageState createState() => _ChattingListPageState();
}

class _ChattingListPageState extends State<ChattingListPage> {
  Map<String, bool> unreadMessages = {
    "User 1": true,
    "User 2": false,
    "User 3": true,
    "User 4": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatting List'),
      ),
      body: ListView.builder(
        itemCount: unreadMessages.length,
        itemBuilder: (BuildContext context, int index) {
          String user = unreadMessages.keys.elementAt(index);
          bool hasUnreadMessage = unreadMessages[user] ?? false;
          return ListTile(
            title: Text(user),
            trailing: hasUnreadMessage
                ? Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            )
                : null,
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChattingDetailPage(user: user),
                ),
              );

              setState(() {
                unreadMessages[user] = false;
              });
            },
          );
        },
      ),
    );
  }
}
