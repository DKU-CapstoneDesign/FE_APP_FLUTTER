import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../model/discover.dart';


class DiscoverDetailPage extends StatefulWidget {
  final Discover discover;
  const DiscoverDetailPage({Key? key, required this.discover}) : super(key: key);

  @override
  State<DiscoverDetailPage> createState() => _DiscoverDetailPageState();
}

class _DiscoverDetailPageState extends State<DiscoverDetailPage> {
  final TextEditingController _commentController = TextEditingController();
  bool isLikeClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.discover.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Image.network(
              widget.discover.imageUrl, width: MediaQuery.of(context).size.width * 0.7,
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 40,
              child: Padding(
                padding: EdgeInsets.only(left: 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isLikeClicked = !isLikeClicked;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300), // 애니메이션 지속 시간
                      curve: Curves.easeInOut, // 애니메이션 커브 설정
                      width: isLikeClicked ? 50 : 40, // 클릭 여부에 따라 너비 조정
                      height: isLikeClicked ? 50 : 40, // 클릭 여부에 따라 높이 조정
                      child: Icon(
                        Icons.thumb_up,
                        color: isLikeClicked ? Colors.blue : Colors.grey, // 좋아요 상태에 따라 색상 변경
                        size: 30, // 아이콘 크기
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.only(left:30, right: 30),
              child: Text(
                widget.discover.content,
                style: TextStyle(
                  fontSize: 17
                ),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.only(left:30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "댓글",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Text(
                "s simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 20, top: 8),
        child: TextField(
          controller: _commentController,
          decoration: InputDecoration(
              hintText: "댓글 입력...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  _commentController.clear();
                },
              )
          ),
        ),

      ),

    );
  }
}
