import 'package:capstonedesign/model/discover.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 60, 10, 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
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
                          ?  Color.fromRGBO(92, 67, 239, 50)
                          : Color.fromRGBO(245, 245, 245, 20),
                      foregroundColor: selectedCategory == 'festival'
                          ? Color.fromRGBO(245, 245, 245, 20)
                          : Colors.black,
                      side: BorderSide(color: Colors.white54, width: 1),
                    ),
                    child: const Text('# 축제'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory =
                        selectedCategory == 'sight' ? 'all' : 'sight';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedCategory == 'sight'
                          ?  Color.fromRGBO(92, 67, 239, 50)
                          : Color.fromRGBO(245, 245, 245, 20),
                      foregroundColor: selectedCategory == 'sight'
                          ? Color.fromRGBO(245, 245, 245, 20)
                          : Colors.black,
                      side: BorderSide(color: Colors.white54, width: 1),
                    ),
                    child: const Text('# 주변명소'),
                  ),
                ],
              ),
              const SizedBox(height: 10),

            ],
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