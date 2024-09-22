import 'package:capstonedesign/view/screens/post/editPostPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/user.dart';
import '../../../viewModel/post/postDetailPage_viewModel.dart';
import '../chat/chattingDetailPage.dart';

class PostDetailPage extends StatefulWidget {
  final String boardName;
  final User user;
  final int postId;
  final String currentUserNickname; //현재 유저

  PostDetailPage({Key? key, required this.postId, required this.boardName, required this.currentUserNickname, required this.user})
      : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<PostDetailViewModel>(context, listen: false);
      await viewModel.getPostInfo(widget.postId, widget.user);
    });
  }

  // 새로고침 시 호출할 함수
  Future<void> _refreshPosts(BuildContext context) async {
    final viewModel = Provider.of<PostDetailViewModel>(context, listen: false);
    await viewModel.getPostInfo(widget.postId, widget.user);
  }

  //// 날짜 컨트롤
  String _twoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  String formatDateTime(DateTime dateTime) {
    return '${_twoDigits(dateTime.month)}/${_twoDigits(dateTime.day)} ${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}';
  }

  // 프로필 사진을 클릭했을 때 프로필 보기 & 채팅하기 버튼 띄우기
  void _showProfileOptions(BuildContext context, String otherUserNickname) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('프로필 보기'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('채팅하기'),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChattingDetailPage(
                    currentUserNickname: widget.currentUserNickname,
                    otherUserNickname: otherUserNickname,
                  ),
                ),
              );
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('취소'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          widget.boardName,
          style: const TextStyle(fontFamily: 'SejonghospitalBold', fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Consumer<PostDetailViewModel>(
        builder: (context, viewModel, child) {
          return RefreshIndicator(
            onRefresh: () => _refreshPosts(context),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              //// 작성자 정보
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        _showProfileOptions(context, viewModel.post.nickname);
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            child: Text(
                                              viewModel.post.nickname.isNotEmpty
                                                  ? viewModel.post.nickname[0]
                                                  : '?',
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                viewModel.post.nickname,
                                                style: const TextStyle(
                                                  fontFamily: 'SejonghospitalBold',
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                formatDateTime(viewModel.post.createdAt),
                                                style: const TextStyle(
                                                  fontFamily: 'SejonghospitalLight',
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),


                                  //만약 글 작성자라면 수정/삭제 버튼을 띄우도록
                                  if (viewModel.post.nickname == widget.user.nickname)
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          iconSize: 20.0,
                                          color: Colors.grey,
                                          //수정하기 페이지로 이동
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditPostPage(user: widget.user, boardName: widget.boardName),
                                              ),
                                            );
                                          },
                                        ),
                                        const Text(
                                          "|",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          iconSize: 20.0,
                                          color: Colors.grey,
                                          onPressed: () {
                                            viewModel.deletePost();
                                          },
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              const SizedBox(height: 20.0),



                              // 첨부 파일이 있으면 이미지 표시하기
                              if (viewModel.post.attachments != null &&
                                  viewModel.post.attachments!.isNotEmpty)
                                Container(
                                  margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.network(
                                    viewModel.post.attachments!.first['filePath'] ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              SizedBox(height: 30),



                              // 게시글 내용
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      viewModel.post.title,
                                      style: const TextStyle(
                                          fontSize: 22.0,
                                          fontFamily: 'SejonghospitalBold'),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      viewModel.post.contents,
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'SejonghospitalLight'),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30.0),

                              // 좋아요와 댓글 수
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          viewModel.isLiked
                                              ? Icons.thumb_up_alt
                                              : Icons.thumb_up_alt_outlined,
                                          color: viewModel.isLiked
                                              ? Color.fromRGBO(92, 67, 239, 1)
                                              : Colors.grey,
                                        ),
                                        onPressed: viewModel.toggleLike,
                                      ),
                                      Text(
                                        '${viewModel.post.likeCount}',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.comment, color: Colors.grey),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        '${viewModel.post.commentList.length}',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24.0),
                              Container(
                                height: 17,
                                width: double.infinity,
                                color: Color.fromRGBO(245, 245, 245, 20),
                              ),

                              // 댓글 리스트
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: viewModel.post.commentList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        viewModel.post.commentList[index],
                                        style: const TextStyle(
                                            fontFamily: 'SejonghospitalLight'),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 16.0),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // 댓글 입력란
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: '댓글을 입력하세요.',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Color.fromRGBO(92, 67, 239, 50),
                                  width: 2.0),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_upward,
                                color: Color.fromRGBO(92, 67, 239, 50),
                              ),
                              onPressed: () {
                                // 전송 버튼 클릭 시 동작
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}