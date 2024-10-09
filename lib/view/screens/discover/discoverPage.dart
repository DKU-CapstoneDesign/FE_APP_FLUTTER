import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/discover.dart';
import '../../../model/user.dart';
import '../../../viewModel/discover/discoverPage_viewModel.dart';
import 'discoverDetailPage.dart';

class DiscoverPage extends StatefulWidget {
  final User user;
  const DiscoverPage({Key? key, required this.user}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String selectedCategory = 'all';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DiscoverViewModel(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //// 검색
                const Row(
                  children: [
                    SizedBox(width: 30),
                    SizedBox(
                      width: 350,
                      height: 45,
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(238, 238, 238, 1),
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          prefixIcon: Icon(Icons.search, color: Colors.black54),
                          hintText: '어디로 가세요?',
                          hintStyle: TextStyle(color: Colors.black54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                //// 선택 토글
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = selectedCategory == 'festival'
                              ? 'all'
                              : 'festival';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == 'festival'
                            ? const Color.fromRGBO(92, 67, 239, 60)
                            : Color(0xFFEDE7F6),
                        foregroundColor: selectedCategory == 'festival'
                            ? const Color.fromRGBO(245, 245, 245, 20)
                            : Colors.black,
                        side: const BorderSide(color: Colors.white54, width: 1),
                      ),
                      child: const Text(
                        '🎡 축제',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SejonghospitalLight',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = selectedCategory == 'sight' ? 'all' : 'sight';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == 'sight'
                            ? const Color.fromRGBO(92, 67, 239, 60)
                            : Color(0xFFEDE7F6),
                        foregroundColor: selectedCategory == 'sight'
                            ? const Color.fromRGBO(245, 245, 245, 20)
                            : Colors.black,
                        side: const BorderSide(color: Colors.white54, width: 1),
                      ),
                      child: const Text('👀 주변 명소',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SejonghospitalLight',
                        ),
                      ),
                    ),
                  ],
                ),

               //// 글 목록
                Consumer<DiscoverViewModel>(
                  builder: (context, viewModel, child) {
                    final posts = viewModel.filteredDiscoverPosts(selectedCategory);
                    return _buildGridView(posts);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  //// grid 형식의 글
  Widget _buildGridView(List<Discover> posts) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 열 갯수
        crossAxisSpacing: 5, // 양 옆
        mainAxisSpacing: 5, // 위 아래
        childAspectRatio: 1, // 1:1
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DiscoverDetailPage(discover: posts[index], boardName: '', user: widget.user, postId: 0, currentUserNickname: '',),
            ));
          },
          child: Image.network(
            posts[index].imageUrl,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}