import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/post/postDetailPage_viewModel.dart';
import '../chat/chattingDetailPage.dart';

class PostDetailPage extends StatefulWidget {
  final String boardName;
  final int postId;
  final String currentUserNickname; //현재 유저

  PostDetailPage({Key? key, required this.postId, required this.boardName, required this.currentUserNickname})
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
      await viewModel.getPostInfo(widget.postId);
    });
  }

  // 새로고침 시 호출할 함수
  Future<void> _refreshPosts(BuildContext context) async {
    final viewModel = Provider.of<PostDetailViewModel>(context, listen: false);
    await viewModel.getPostInfo(widget.postId);
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
                MaterialPageRoute(builder: (context) => ChattingDetailPage(currentUserNickname: widget.currentUserNickname, otherUserNickname: otherUserNickname)),
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

          // 위로 당기면 새로고침할 수 있도록
          return RefreshIndicator(
            onRefresh: () => _refreshPosts(context),
            child: GestureDetector(
              // 입력 필드 외부를 터치하면 키보드 닫힘
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
                              // 작성자 정보
                              ListTile(
                                leading: GestureDetector(
                                  onTap: () {
                                    _showProfileOptions(context, viewModel.post.nickname);
                                  },
                                  child: const CircleAvatar(
                                    backgroundImage: AssetImage('assets/avatar.png'),
                                  ),
                                ),
                                title: Text(
                                  viewModel.post.nickname,
                                  style: const TextStyle(fontFamily: 'SejonghospitalBold'),
                                ),
                                subtitle: Text(
                                  formatDateTime(viewModel.post.createdAt),
                                  style: const TextStyle(
                                      fontFamily: 'SejonghospitalLight', color: Colors.grey),
                                ),
                              ),
                              const SizedBox(height: 20.0),

                              // 게시글 내용
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8.0),
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
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Color.fromRGBO(92, 67, 239, 50), width: 2.0),
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