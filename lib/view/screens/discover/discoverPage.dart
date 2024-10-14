import 'package:capstonedesign/model/discover_festival.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/discover/discoverDetailPage_viewModel.dart';
import 'discoverDetailPage.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String selectedCategory = 'all'; // 초기 카테고리 설정

  @override
  void initState() {
    super.initState();
    // ViewModel 초기화 및 데이터 로드
   /* WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DiscoverDetailViewModel>(context, listen: false).fetchAllPosts();
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DiscoverDetailViewModel(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

                //// 카테고리 선택 버튼 (축제, 명소, 쇼핑)
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
                      child: const Text(
                        '👀 주변 명소',
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
                          selectedCategory = selectedCategory == 'advertise'
                              ? 'all'
                              : 'advertise';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == 'advertise'
                            ? const Color.fromRGBO(92, 67, 239, 60)
                            : Color(0xFFEDE7F6),
                        foregroundColor: selectedCategory == 'advertise'
                            ? const Color.fromRGBO(245, 245, 245, 20)
                            : Colors.black,
                        side: const BorderSide(color: Colors.white54, width: 1),
                      ),
                      child: const Text(
                        '🛍 쇼핑',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SejonghospitalLight',
                        ),
                      ),
                    ),
                  ],
                ),

                //// 글 목록 표시
                /*Consumer<DiscoverDetailViewModel>(
                  builder: (context, viewModel, child) {
                    final posts = viewModel.filteredDiscoverPosts(selectedCategory);
                    return _buildGridView(posts);
                  },
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  //// Grid 형태로 글 목록 표시
  Widget _buildGridView(List<DiscoverFestival> posts) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 열 갯수
        crossAxisSpacing: 5, // 좌우 간격
        mainAxisSpacing: 5, // 상하 간격
        childAspectRatio: 1, // 1:1 비율
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DiscoverDetailPage(discover: posts[index]),
            ));
          },
          child: Image.network(
            posts[index].image_url,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}