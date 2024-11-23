import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../dataSource/post_dataSource.dart';
import '../../../model/post.dart';
import '../../../model/user.dart';
import '../../../viewModel/post/createPostPage_viewModel.dart';

class CreatePostPage extends StatefulWidget {
  final String boardName; //category
  final User user;
  CreatePostPage({required this.user, required this.boardName});

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {

  @override
  Widget build(BuildContext context) {
    //상태 관리
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
        ),
        //consumer를 이용한 상태 관리
        body: Consumer<CreatePostViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      onChanged: (value) {
                        viewModel.title = value;
                        viewModel.category = widget.boardName; //카테고리 설정
                      },
                      decoration: InputDecoration(
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
                        viewModel.attachments != null && viewModel.attachments!.isNotEmpty
                            ? Expanded(
                          child: SizedBox(
                            height: 80,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: viewModel.attachments!.length,
                              itemBuilder: (context, index) {
                                final attachment = viewModel.attachments![index];
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
                                        child: Image.file(
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
                            : Container(
                          height: 80,
                          width: 80,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    Container(
                      height: 450,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        onChanged: (value) => viewModel.contents = value,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration : InputDecoration(
                          hintText: tr("post_content_hint"),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: viewModel.isPosting
                        ? null
                        : () {
                        viewModel.createPost(context);
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
                      child: Text(tr("complete")),
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