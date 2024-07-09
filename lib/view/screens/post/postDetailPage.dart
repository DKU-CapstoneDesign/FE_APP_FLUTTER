import 'package:flutter/material.dart';
import 'package:capstonedesign/model/post.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  bool _isLiked = false;
  final TextEditingController _commentController = TextEditingController();

  List<String> comments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '작성자: ${widget.post.uploaderId}', // 작성자 ID
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '작성일: ${widget.post.created_at}', // 작성일자
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                widget.post.title,
                style: TextStyle(fontSize: 25.0),
              ),
              Container(
                alignment: Alignment.center,
                // child: Image.asset(
                //   'assets/다운로드.jpeg',
                //   width: 300,
                //   height: 200,
                //   fit: BoxFit.cover,
                // ),
              ),
              const SizedBox(height: 16.0),
              Text(
                widget.post.content,
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  IconButton(
                    icon: _isLiked ? Icon(Icons.thumb_up_alt) : Icon(Icons.thumb_up_alt_outlined),
                    onPressed: _isLiked
                        ? null
                        : () {
                      setState(() {
                        _isLiked = true;
                        widget.post.likes++;
                      });
                    },
                  ),
                  Text('${widget.post.likes}'),
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),
              const SizedBox(height: 16.0),
              const Text(
                '댓글',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 8.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(comments[index]),
                    ),
                  );
                },
              ),
              const SizedBox(height: 150.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: '댓글을 입력하세요',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        comments.add(_commentController.text);
                        _commentController.clear();
                      });
                    },
                    child: const Text('댓글 작성'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
