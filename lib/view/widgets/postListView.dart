import 'package:flutter/material.dart';
import 'package:capstonedesign/model/cardForm.dart';
import '../screens/discover/discoverDetailPage.dart';

class PostListView extends StatelessWidget {
  final List<CardForm> cardForms;
  const PostListView({Key? key, required this.cardForms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.55,
      ),
      child: PageView.builder(
        itemCount: cardForms.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                color: Color.fromRGBO(92, 67, 239, 60),
              ),
              child: GestureDetector(
                onTap: () {
                  print("post clicked!!!");
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DiscoverDetailPage(cardForm: cardForms[index])));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        cardForms[index].imageUrl,
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
                          padding: const EdgeInsets.fromLTRB(30,30, 30, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cardForms[index].title,
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "자세히 보기                            >",
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
            ),
          );
        },
        scrollDirection: Axis.horizontal, // Horizontal scroll
      ),
    );
  }
}