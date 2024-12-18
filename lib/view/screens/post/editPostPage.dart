import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../dataSource/post_dataSource.dart';
import '../../../model/user.dart';
import '../../../model/post.dart';
import '../../../viewModel/post/editPostPage_viewModel.dart';

class EditPostPage extends StatefulWidget {
  final String boardName; // category
  final User user;
  final Post post;

  EditPostPage({required this.user, required this.boardName, required this.post});

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    // TextEditingController로 기존 제목과 내용을 초기화
    _titleController = TextEditingController(text: widget.post.title);
    _contentController = TextEditingController(text: widget.post.contents);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditPostViewModel(PostDataSource(), widget.post),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
          title:  Text(tr("edit_post_title"))
        ),
        body: Consumer<EditPostViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration:  InputDecoration(
                        hintText: tr("title_hint"),
                      ),
                    ),
                    SizedBox(height: 30.0),

                    //// 이미지 선택 및 미리보기
                    Row(
                      children: [
                        // 이미지 선택 버튼
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add_photo_alternate, size: 30, color: Colors.grey),
                            onPressed: () => viewModel.getImage(), // 여러 이미지 선택
                          ),
                        ),
                        SizedBox(width: 20),

                        // 이미지 미리보기 및 삭제 버튼
                        if (viewModel.attachments.isNotEmpty)
                          Expanded(
                            child: SizedBox(
                              height: 80,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: viewModel.attachments.length,
                                itemBuilder: (context, index) {
                                  final attachment = viewModel.attachments[index];
                                  return Stack(
                                    children: [
                                      // 이미지 미리보기
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: attachment['filePath']!.contains('http')
                                              ? Image.network(
                                            attachment['filePath']!,
                                            fit: BoxFit.cover,
                                          )
                                              : Image.file(
                                            File(attachment['filePath']!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      // 삭제 버튼
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            viewModel.removeImage(index); // 이미지 제거 함수 호출
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.6),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          )
                        else
                          Container(
                            height: 80,
                            width: 80,
                          ),
                      ],
                    ),
                    SizedBox(height: 20),

                    Container(
                      height: 510,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        controller: _contentController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16.0),
                          hintText: tr("post_content_hint"),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        viewModel.title = _titleController.text;
                        viewModel.contents = _contentController.text;
                        await viewModel.editPost(context, widget.user.id.toString(), widget.post.id, widget.user); // 게시글 수정 요청
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(92, 67, 239, 60)),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 48, vertical: 18),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: Text(tr("edit_button")),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}