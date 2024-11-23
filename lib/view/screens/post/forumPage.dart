import 'package:capstonedesign/view/screens/post/postListPage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:capstonedesign/view/widgets/infoBox.dart';
import 'package:provider/provider.dart';
import '../../../dataSource/post_dataSource.dart';
import '../../../model/user.dart';
import '../../../viewModel/post/postListPage_viewModel.dart';

class ForumPage extends StatefulWidget {
  final User user;
  ForumPage({Key? key, required this.user}) : super(key: key);
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final Map<String, bool> _buttonTappedStates = {
    tr('latest_board'): false,
    tr('free_board'): false,
    tr('help_board'): false,
    tr('travel_board'): false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(92, 67, 239, 60),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          tr("forum_title"),
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
            Infobox(tr("forum_info_title"), tr("forum_info_subtitle")),
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
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) => PostListViewModel(PostDataSource()),
              child: PostListPage(
                user: widget.user,
                boardName: boardName.replaceAll('\n', ""),
              ),
            ),
          ),
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
          color: isTapped ? const Color.fromRGBO(92, 67, 239, 100) : Color.fromRGBO(92, 67, 239, 220),
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