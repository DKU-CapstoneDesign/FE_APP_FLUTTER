import 'package:capstonedesign/view/screens/chatBot/chatBotPage.dart';
import 'package:capstonedesign/view/screens/discover/discoverPage.dart';
import 'package:flutter/material.dart';
import 'package:capstonedesign/view/screens/post/forumPage.dart';
import 'package:capstonedesign/view/screens/chat/chattingListPage.dart';
import '../screens/first/homePage.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ChatBotPage(),
    ChattingListPage(),
    ForumPage(),
    DiscoverPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.purple,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.adb),
            label: '챗봇',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum_outlined),
            label: '게시판',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '살펴보기',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}