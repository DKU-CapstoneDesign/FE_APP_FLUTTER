import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../dataSource/post_dataSource.dart';
import '../../../model/user.dart';
import '../../../viewModel/post/createPostPage_viewModel.dart';

class EditPostPage extends StatefulWidget {
  final String boardName; // category
  final User user;

  EditPostPage({required this.user, required this.boardName});

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
    _titleController = TextEditingController(text: '');
    _contentController = TextEditingController(text: '');
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
      create: (_) => CreatePostViewModel(PostDataSource(), widget.user),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
          title: Text('게시글 수정하기'),
        ),
        body: Consumer<CreatePostViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _titleController,
                      onChanged: (value) {
                        //viewModel.post.title = value;
                      },
                      decoration: const InputDecoration(
                        hintText: '글 제목',
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
                        if (viewModel.post.attachments != null && viewModel.post.attachments!.isNotEmpty)
                          Expanded(
                            child: SizedBox(
                              height: 80,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: viewModel.post.attachments!.length,
                                itemBuilder: (context, index) {
                                  final attachment = viewModel.post.attachments![index];
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
                                          child: attachment['filePath']!.contains('http') // 네트워크 이미지인지 확인
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
                        onChanged: (value) => viewModel.post.contents = value,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16.0),
                          hintText: '게시판에 올릴 게시글 내용을 작성해주세요 \n건강한 게시판 문화를 지향합니다:)',
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        await viewModel.editPost(context); // 게시글 수정 요청
                        Navigator.pop(context, true); // 수정 후 페이지 이동
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
                      child: Text('수정 완료'),
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