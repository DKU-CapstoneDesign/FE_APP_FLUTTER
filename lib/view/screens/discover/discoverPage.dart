import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/discover/discoverPage_viewModel.dart';
import 'discoverDetailPage_advertisement.dart';
import 'discoverDetailPage_festival.dart';
import 'discoverDetailPage_sight.dart';

enum DiscoverCategory { all, festival, sight, advertise }

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  DiscoverCategory selectedCategory = DiscoverCategory.all;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DiscoverViewModel>(context, listen: false).getAllPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
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

                  // 필터링 버튼
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCategoryButton('🎡 축제', DiscoverCategory.festival),
                      const SizedBox(width: 10),
                      _buildCategoryButton('👀 주변 명소', DiscoverCategory.sight),
                      const SizedBox(width: 10),
                      _buildCategoryButton('🛍 쇼핑', DiscoverCategory.advertise),
                    ],
                  ),

                  // 내용 (grid 형식으로)
                  Consumer<DiscoverViewModel>(
                    builder: (context, viewModel, child) {
                      final posts = viewModel.filteredDiscoverPosts(selectedCategory.name);
                      return _buildGridView(posts, viewModel);
                    },
                  ),
                ],
              ),
            ),
          ),

          // 데이터 받아올 때까지 로딩 화면
          // loading_indicator 패키지 이용
          Consumer<DiscoverViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.loading) {
                return Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    child: const LoadingIndicator(
                      indicatorType: Indicator.ballPulseSync,
                      colors: [
                        Color.fromRGBO(92, 67, 239, 100),
                        Color.fromRGBO(92, 67, 239, 60),
                        Color.fromRGBO(92, 67, 239, 20),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink(); // 로딩 아니면 없어지도록
            },
          ),
        ],
      ),
    );
  }

  // 카테고리 버튼
  Widget _buildCategoryButton(String title, DiscoverCategory category) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedCategory = selectedCategory == category ? DiscoverCategory.all : category;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedCategory == category
            ? const Color.fromRGBO(92, 67, 239, 60)
            : const Color(0xFFEDE7F6),
        foregroundColor: selectedCategory == category
            ? const Color.fromRGBO(245, 245, 245, 20)
            : Colors.black,
        side: const BorderSide(color: Colors.white54, width: 1),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontFamily: 'SejonghospitalLight',
        ),
      ),
    );
  }

  // 그리드 형식의 사진
  Widget _buildGridView(List<dynamic> posts, DiscoverViewModel viewModel) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (MediaQuery.of(context).size.width ~/ 120),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 1,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final item = posts[index];
        final imageUrl = item.image_url; // 내용에서 이미지만 가져와서 보여주도록

        return GestureDetector(
          onTap: () {
            String category = viewModel.getItemCategory(item);


            if (category == 'festival') {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DiscoverFestivalDetailPage(discover: item),
              ));
            } else if (category == 'sight') {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DiscoverSightDetailPage(discover: item),
              ));
            } else if (category == 'advertise') {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DiscoverAdvertisementDetailPage(discover: item),
              ));
            }
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
        );
      },
    );
  }
}