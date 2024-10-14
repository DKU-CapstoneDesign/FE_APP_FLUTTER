import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../dataSource/comment_dataSource.dart';
import '../../../dataSource/post_dataSource.dart';
import '../../../model/discover_sight.dart';
import '../../../model/user.dart';
import '../../../viewModel/discover/discoverDetailPage_viewModel.dart';

class DiscoverDetailPage extends StatefulWidget {
  final Discover discover;

  const DiscoverDetailPage({
    Key? key,
    required this.discover,
  }) : super(key: key);

  @override
  State<DiscoverDetailPage> createState() => _DiscoverDetailPageState();
}

class _DiscoverDetailPageState extends State<DiscoverDetailPage> {
  bool isLikeClicked = false;
  FocusNode _focusNode = FocusNode(); // FocusNode for handling the keyboard

  @override
  void initState() {
    super.initState();
    // Initialize ViewModel and get post info and comments after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<DiscoverDetailViewModel>(context, listen: false);
    });
  }

  //// Function to show the comment sheet
  void _showCommentSheet(BuildContext context) {
    final viewModel = Provider.of<DiscoverDetailViewModel>(context, listen: false);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
    return FractionallySizedBox(
    heightFactor: 0.7, // Sheet takes up 70% of the screen height
    child: Padding(
    padding: MediaQuery.of(context).viewInsets,
    child: Column(
    mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        // Small bar at the top of the modal for drag indication
        Container(
          height: 4,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          '댓글',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
        const SizedBox(height: 20),

        // Comment List
       /* Expanded(
          child: ListView.builder(
            itemCount: viewModel.commentList.length,
            itemBuilder: (context, index) {
              final comment = viewModel.post.commentList[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(
                    comment.nickname.isNotEmpty ? comment.nickname[0] : '?',
                  ),
                ),
                title: Text(comment.nickname),
                subtitle: Text(comment.contents),
              );
            },
          ),
        ),*/

        // Comment Input Field
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: _focusNode, // Control keyboard focus
                  controller: viewModel.commentController,
                  decoration: InputDecoration(
                    hintText: '댓글을 입력하세요.',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color.fromRGBO(92, 67, 239, 50),
                      width: 2.0),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_upward,
                    color: Color.fromRGBO(92, 67, 239, 50),
                  ),
                  onPressed: () async {

                    _focusNode.unfocus(); // Dismiss the keyboard
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    ),
    );
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DiscoverDetailViewModel(), // ViewModel creation
      child: Scaffold(
        appBar: AppBar(
        ),
        body: Consumer<DiscoverDetailViewModel>(
          builder: (context, viewModel, child) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(), // Hide keyboard when tapped outside
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                      child: Center(
                        child: Text(
                          widget.discover.title,
                          style: const TextStyle(
                            fontFamily: 'Sejonghospital',
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Image.network(
                        widget.discover.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Like and Comment Buttons
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isLikeClicked = !isLikeClicked;
                              });
                            },
                            child: Icon(
                              Icons.thumb_up,
                              color: isLikeClicked
                                  ? const Color.fromRGBO(92, 67, 239, 1)
                                  : Colors.grey,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              _showCommentSheet(context); // Show comment sheet when comment icon is tapped
                            },
                            child: const Icon(
                              Icons.comment,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Post Content
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                      child: Text(
                        widget.discover.content,
                        style: const TextStyle(
                          fontSize: 17,
                          fontFamily: 'SejonghospitalLight',
                        ),
                      ),
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