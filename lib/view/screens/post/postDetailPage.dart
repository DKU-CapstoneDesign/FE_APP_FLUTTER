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
  final String currentUserNickname; // 현재 유저

  PostDetailPage({
    Key? key,
    required this.postId,
    required this.boardName,
    required this.currentUserNickname,
    required this.user,
  }) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  int? parentCommentId; // 부모 댓글 ID
  FocusNode _focusNode = FocusNode(); // 키보드 제어용 FocusNode

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<PostDetailViewModel>(context, listen: false);
      await viewModel.getPostInfo(widget.postId, widget.user);
      print(viewModel.post.commentList);
    });
  }

  // 새로고침 시 호출할 함수
  Future<void> _refreshPosts(BuildContext context) async {
    final viewModel = Provider.of<PostDetailViewModel>(context, listen: false);
    await viewModel.getPostInfo(widget.postId, widget.user);
    await viewModel.getComment(widget.postId);
  }

  //// 날짜 포맷팅 함수
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
            child: const Text('채팅하기'),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChattingDetailPage(
                    currentUserNickname: widget.currentUserNickname,
                    otherUserNickname: otherUserNickname,
                    user: widget.user,
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

  // 댓글 또는 대댓글 작성 시 호출
  Future<void> _submitComment(BuildContext context) async {
    final viewModel = Provider.of<PostDetailViewModel>(context, listen: false);
    await viewModel.createComment(widget.postId, parentCommentId ?? 0); // 대댓글일 경우 parentCommentId 사용
    await _refreshPosts(context); // 댓글 작성 후 새로고침
    parentCommentId = null; // 대댓글 상태 초기화
    FocusScope.of(context).unfocus(); // 키보드 내리기
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
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 작성자 정보
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        if (widget.currentUserNickname != viewModel.post.nickname) {
                                          _showProfileOptions(context, viewModel.post.nickname);
                                        }
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

                                  if (viewModel.post.nickname == widget.user.nickname)
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          iconSize: 20.0,
                                          color: Colors.grey,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditPostPage(
                                                    user: widget.user,
                                                    boardName: widget.boardName,
                                                    post: viewModel.post
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const Text("|", style: TextStyle(color: Colors.grey, fontSize: 20.0)),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          iconSize: 20.0,
                                          color: Colors.grey,
                                          onPressed: () {
                                            viewModel.deletePost(context, widget.postId, widget.user);
                                          },
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              const SizedBox(height: 20.0),

                              // 첨부 파일 표시
                              if (viewModel.post.attachments != null && viewModel.post.attachments!.isNotEmpty)
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: viewModel.post.attachments?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Image.network(
                                          viewModel.post.attachments![index]['filePath'] ?? '',
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              const SizedBox(height: 30),

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
                                        onPressed: () async {
                                          await viewModel.toggleLike(widget.postId, widget.user.id, widget.user);
                                        },
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
                              if (viewModel.post.commentList.isNotEmpty)
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  reverse: true, // 댓글을 거꾸로 표시
                                  itemCount: viewModel.post.commentList.length,
                                  itemBuilder: (context, index) {
                                    final comment = viewModel.post.commentList[index];

                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(15.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 15.0,
                                                      child: Text(
                                                        comment.nickname.isNotEmpty ? comment.nickname[0] : '?',
                                                        style: TextStyle(fontSize: 14.0),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),

                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          // 닉네임과 작성 시간
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    comment.nickname,
                                                                    style: const TextStyle(
                                                                      fontFamily: 'SejonghospitalBold',
                                                                      fontSize: 14.0,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 2.0),
                                                                  Text(
                                                                    formatDateTime(comment.createdAt),
                                                                    style: const TextStyle(
                                                                      fontSize: 12.0,
                                                                      color: Colors.grey,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(height: 15.0),

                                                          // 댓글 내용
                                                          Text(
                                                            comment.contents,
                                                            style: const TextStyle(
                                                              fontFamily: 'SejonghospitalLight',
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10.0),

                                                          // 답글 달기
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                parentCommentId = comment.id; // 대댓글로 설정
                                                                _focusNode.requestFocus(); // 키보드 올리기
                                                              });
                                                            },
                                                            child: const Text(
                                                              '답글 달기',
                                                              style: TextStyle(
                                                                color: Colors.grey,
                                                                fontSize: 14.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    // 댓글 삭제 (작성자만 가능)
                                                    if (comment.nickname == widget.currentUserNickname)
                                                      IconButton(
                                                        icon: const Icon(Icons.close, color: Colors.grey),
                                                        iconSize: 18.0,
                                                        onPressed: () async {
                                                          await viewModel.deleteComment(comment.id);
                                                          await _refreshPosts(context);
                                                        },
                                                      ),
                                                  ],
                                                ),
                                              ),


                                              //// 대댓글
                                              if (comment.childCommentList != null && comment.childCommentList!.isNotEmpty)
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: comment.childCommentList!.length,
                                                  itemBuilder: (context, childIndex) {
                                                    final reply = comment.childCommentList![childIndex];
                                                    return Padding(
                                                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const Text(
                                                              "↳",
                                                              style: TextStyle(color:Colors.grey,fontSize: 20
                                                              ),
                                                          ),
                                                          const SizedBox(width: 10),

                                                          CircleAvatar(
                                                            radius: 15.0,
                                                            child: Text(
                                                              reply.nickname.isNotEmpty ? reply.nickname[0] : '?',
                                                              style: TextStyle(fontSize: 14.0),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 10),

                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          reply.nickname,
                                                                          style: const TextStyle(
                                                                            fontFamily: 'SejonghospitalBold',
                                                                            fontSize: 14.0,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(height: 2.0),
                                                                        Text(
                                                                          formatDateTime(reply.createdAt),
                                                                          style: const TextStyle(
                                                                            fontSize: 12.0,
                                                                            color: Colors.grey,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(height: 15.0),

                                                                Text(
                                                                  reply.contents,
                                                                  style: const TextStyle(
                                                                    fontFamily: 'SejonghospitalLight',
                                                                    fontSize: 14.0,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                          // 대댓글 삭제 (작성자만 가능)
                                                          if (reply.nickname == widget.currentUserNickname)
                                                            IconButton(
                                                              icon: const Icon(Icons.close, color: Colors.grey),
                                                              iconSize: 18.0,
                                                              onPressed: () async {
                                                                await viewModel.deleteComment(reply.id);
                                                                await _refreshPosts(context);
                                                              },
                                                            ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              const SizedBox(height: 16.0),
                                              Divider(color: Colors.grey[300]),
                                            ],
                                          ),
                                        ),
                                      ],
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
                              focusNode: _focusNode, // 키보드 제어용 FocusNode
                              controller: viewModel.commentController,
                              decoration: InputDecoration(
                                prefixIcon: parentCommentId != null // 대댓글일 경우 화살표 표시
                                    ? const Icon(Icons.reply, color: Color.fromRGBO(92, 67, 239, 50))
                                    : null,
                                hintText: '댓글을 입력하세요.',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
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
                                  color: Color.fromRGBO(92, 67, 239, 50),
                                  width: 2.0),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_upward,
                                color: Color.fromRGBO(92, 67, 239, 50),
                              ),
                              onPressed: () async {
                                await _submitComment(context);
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