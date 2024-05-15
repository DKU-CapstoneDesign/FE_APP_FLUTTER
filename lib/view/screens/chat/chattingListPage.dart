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
      body: ListView.builder(
        itemCount: unreadMessages.length,
        itemBuilder: (BuildContext context, int index) {
          String user = unreadMessages.keys.elementAt(index);
          bool hasUnreadMessage = unreadMessages[user] ?? false;
          return Column(
            children: <Widget>[
              if (index == 0) SizedBox(height: 50.0),
              InkWell(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Text(user[0]),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '미리보기',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        '11:30 AM',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      if (hasUnreadMessage)
                        Container(
                          width: 10,
                          height: 10,
                          margin: EdgeInsets.only(left: 8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.grey[300]),
            ],
          );
        },
      ),
    );
  }
}
