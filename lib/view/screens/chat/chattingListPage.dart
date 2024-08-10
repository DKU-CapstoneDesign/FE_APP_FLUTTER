import 'package:flutter/material.dart';
import 'package:capstonedesign/view/screens/chat/chattingDetailPage.dart';
import 'package:capstonedesign/view/widgets/infoBox.dart';

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
        backgroundColor: Color.fromRGBO(92, 67, 239, 60),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "채팅하기",
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontFamily: 'SejonghospitalBold',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Infobox("채팅 페이지입니다", "1:1 대화로 친구를 만들어봐요"),
            SizedBox(height: 40.0),
            // ListView를 Expanded로 감싸서 남은 공간을 채우도록 함
            Expanded(
              child: ListView.builder(
                itemCount: unreadMessages.length,
                itemBuilder: (BuildContext context, int index) {
                  String user = unreadMessages.keys.elementAt(index);
                  bool hasUnreadMessage = unreadMessages[user] ?? false;
                  return Column(
                    children: <Widget>[
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
                          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 5.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                child: Text(user[0]),
                              ),
                              SizedBox(width: 26.0),
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
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}