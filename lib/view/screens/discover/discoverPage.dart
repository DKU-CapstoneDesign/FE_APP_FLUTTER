import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/discover.dart';
import '../../../viewModel/discover/discoverPage_viewModel.dart';
import 'discoverDetailPage.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    SizedBox(width: 15),
                    SizedBox(
                      width: 350,
                      height: 45,
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            ? const Color.fromRGBO(92, 67, 239, 50)
                            : const Color.fromRGBO(245, 245, 245, 20),
                        foregroundColor: selectedCategory == 'festival'
                            ? const Color.fromRGBO(245, 245, 245, 20)
                            : Colors.black,
                        side: const BorderSide(color: Colors.white54, width: 1),
                      ),
                      child: const Text('# 축제'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = selectedCategory == 'sight' ? 'all' : 'sight';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == 'sight'
                            ? const Color.fromRGBO(92, 67, 239, 50)
                            : const Color.fromRGBO(245, 245, 245, 20),
                        foregroundColor: selectedCategory == 'sight'
                            ? const Color.fromRGBO(245, 245, 245, 20)
                            : Colors.black,
                        side: const BorderSide(color: Colors.white54, width: 1),
                      ),
                      child: const Text('# 주변명소'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
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

  Widget _buildGridView(List<Discover> posts) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 columns
        crossAxisSpacing: 5, // Horizontal spacing
        mainAxisSpacing: 5, // Vertical spacing
        childAspectRatio: 1, // 1:1 aspect ratio for same-size images
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
            posts[index].imageUrl,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}