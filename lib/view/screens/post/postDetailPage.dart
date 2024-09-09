import 'package:capstonedesign/dataSource/post_dataSource.dart';
import 'package:flutter/material.dart';
import 'package:capstonedesign/model/post.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../viewModel/post/postDetailPage_viewModel.dart';

class PostDetailPage extends StatefulWidget {
  final Post post; // Post 객체를 전달받음
  PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    // 상태 관리
    return ChangeNotifierProvider(
      create: (_) => PostDetailViewModel(PostDataSource()),

      child: Scaffold(
        appBar: AppBar(
          title: Text('게시글 상세'),
        ),
        //consumer를 이용한 상태 관리
        /*provider 대신 consumer를 사용한 이유??
        => 상태 관리를 더 명확하게 하고, 특정 위젯들만 다시 빌드할 수 있기 때문*/
        body: Consumer<PostDetailViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 작성자와 작성일 표시
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '작성자: ${viewModel.username}', // 작성자 이름
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '작성일: ${_formatDate(viewModel.createdAt)}', // 작성일자 형식화
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    // 게시글 제목
                    Text(
                      viewModel.title,
                      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    // 게시글 내용
                    Text(
                      viewModel.contents,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    // 좋아요 버튼과 카운트
                    /*Row(
                      children: [
                        IconButton(
                          *//*icon: viewModel.likeCount
                              ? Icon(Icons.thumb_up_alt, color: Colors.blue)
                              : Icon(Icons.thumb_up_alt_outlined),*//*
                          onPressed: () {
                            //viewModel.toggleLike(); // 좋아요 상태 토글
                          },
                        ),
                        Text('${viewModel.post.likeCount}'),
                      ],
                    ),*/
                    const Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                    const SizedBox(height: 16.0),
                    // 댓글 목록 표시
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
                      physics: NeverScrollableScrollPhysics(), // 스크롤 방지
                      itemCount: viewModel.contents.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Text(viewModel.contents[index]), // 댓글 내용 표시
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 150.0),
                    // 댓글 입력 및 작성 버튼
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: '댓글을 입력하세요',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        ElevatedButton(
                          onPressed: () {
                            // 댓글 추가// 입력창 초기화
                          },
                          child: const Text('댓글 작성'),
                        ),
                      ],
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

  // 날짜 형식화 함수
  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date); // yyyy-MM-dd 형식으로 표시
  }
}