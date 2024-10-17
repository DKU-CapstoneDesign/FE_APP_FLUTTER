import 'package:capstonedesign/model/discover_festival.dart';
import 'package:flutter/material.dart';
import 'package:capstonedesign/model/discover_sight.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../screens/discover/discoverDetailPage.dart';

class PostListView extends StatefulWidget {
  final List<DiscoverFestival> cardForms;
  const PostListView({Key? key, required this.cardForms}) : super(key: key);

  @override
  _PostListViewState createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  @override
  Widget build(BuildContext context) {
    //carousel_slider 패키지를 사용하여 캐러샐 카드 만들기
    return CarouselSlider.builder(
      itemCount: widget.cardForms.length,
      itemBuilder: (context, index, realIndex) {
        return Container(
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              color: Color.fromRGBO(92, 67, 239, 60),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DiscoverDetailPage(discover: widget.cardForms[index]),
                ));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.cardForms[index].image_url,
                      height: 250.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cardForms[index].name,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontFamily: 'SejonghospitalBold',
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.cardForms[index].period,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: 'SejonghospitalLight',
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            SizedBox(height: 10.0),
                            const Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "자세히 보기                  >",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
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
            ),
          );
      },
      options: CarouselOptions(
        height: 500,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true, //무한 스크롤 활성화
        autoPlay: true, //자동 재생 활성화
        autoPlayInterval: Duration(seconds: 15),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}