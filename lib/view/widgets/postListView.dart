import 'package:flutter/material.dart';
import 'package:capstonedesign/model/discover.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../screens/discover/discoverDetailPage.dart';

class PostListView extends StatefulWidget {
  final List<Discover> cardForms;
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
                print("post clicked!!!");
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DiscoverDetailPage(discover: widget.cardForms[index], boardName: '', user: widget. , postId: null, currentUserNickname: '',)));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.cardForms[index].imageUrl,
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
                              widget.cardForms[index].title,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontFamily: 'SejonghospitalBold',
                              ),
                            ),
                            SizedBox(height: 10),
                            Divider(
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
        autoPlayInterval: Duration(seconds: 6),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}