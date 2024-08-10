import 'package:flutter/material.dart';
import 'postListPage.dart';
import 'package:capstonedesign/view/widgets/infoBox.dart';

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final Map<String, bool> _buttonTappedStates = {
    'HOT\n게시판': false,
    '자유\n게시판': false,
    '도움\n게시판': false,
    '여행\n게시판': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(92, 67, 239, 60),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "게시판",
          style: TextStyle(
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
            Infobox("환영해요! 게시판입니다.", "사람들과 자유롭게 소통해보세요"),
            SizedBox(height: 60.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 30.0,
                children: _buttonTappedStates.keys.map((boardName) {
                  return _boardButton(context, boardName);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boardButton(BuildContext context, String boardName) {
    bool isTapped = _buttonTappedStates[boardName] ?? false;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _buttonTappedStates[boardName] = true;
        });
      },
      onTapUp: (_) async {
        await Future.delayed(Duration(milliseconds: 200));
        setState(() {
          _buttonTappedStates[boardName] = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostListPage(boardName: boardName.replaceAll('\n', ""))),
        );
      },
      onTapCancel: () {
        setState(() {
          _buttonTappedStates[boardName] = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isTapped ? const Color.fromRGBO(92, 67, 239, 60) : Color.fromRGBO(92, 67, 239, 220),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Text(
            boardName,
            style: const TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'SejonghospitalLight'),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}