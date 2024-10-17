import 'package:capstonedesign/model/discover_festival.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../screens/discover/discoverDetailPage.dart';

class PostListView extends StatefulWidget {
  final List<DiscoverFestival> cardForms;
  const PostListView({Key? key, required this.cardForms}) : super(key: key);

  @override
  _PostListViewState createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  int _currentIndex = 0; // 몇 번째인지


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.cardForms.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                color: Colors.transparent,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DiscoverDetailPage(discover: widget.cardForms[index]),
                  ));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(14.0),
                            topRight: Radius.circular(14.0),
                          ),
                          child: Image.network(
                            widget.cardForms[index].image_url,
                            height: 300.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "${index + 1} / ${widget.cardForms.length}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // White box below the image
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(14.0),
                          bottomRight: Radius.circular(14.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),


                      //// 축제 설명
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cardForms[index].name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'SejonghospitalBold',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.cardForms[index].period,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontFamily: 'SejonghospitalLight',
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Divider(
                              color: Colors.black12,
                              thickness: 1,
                            ),
                            const SizedBox(height: 10.0),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "자세히 보기 >",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontFamily: 'SejonghospitalLight',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 500,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true, //무한 스크롤 허용
            autoPlay: true, //자동 재생
            autoPlayInterval: const Duration(seconds: 15),
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ],
    );
  }
}