import 'package:capstonedesign/model/discover_advertisement.dart';
import 'package:capstonedesign/model/discover_festival.dart';
import 'package:capstonedesign/model/discover_sight.dart';
import 'package:flutter/material.dart';
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

              // Category selection buttons (Festival, Sight, Shopping)
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

              // Display the grid of posts
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
    );
  }

  // Build the category selection button
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

  // Grid view for displaying posts
  Widget _buildGridView(List<dynamic> posts, DiscoverViewModel viewModel) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (MediaQuery.of(context).size.width ~/ 120), // Responsive grid
        crossAxisSpacing: 5, // Horizontal spacing
        mainAxisSpacing: 5, // Vertical spacing
        childAspectRatio: 1, // 1:1 aspect ratio
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final item = posts[index];
        final imageUrl = item.image_url; // Extract image URL from the item

        return GestureDetector(
          onTap: () {
            String category = viewModel.getItemCategory(item);

            // Navigate based on the category and pass the relevant model
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
            imageUrl, // Display image
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error); // Handle image load error
            },
          ),
        );
      },
    );
  }
}
