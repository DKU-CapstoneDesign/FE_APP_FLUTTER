import 'dart:ffi';

import 'package:capstonedesign/view/widgets/cards/verticalPostListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

import '../../../model/cardForm.dart';


class DiscoverSearchPage extends StatefulWidget {
  final String typedLocation;
  const DiscoverSearchPage({Key? key, required this.typedLocation}) : super(key: key);

  @override
  State<DiscoverSearchPage> createState() => _DiscoverSearchPageState();
}

class _DiscoverSearchPageState extends State<DiscoverSearchPage> {
  bool isFestivalButtonPressed = false;
  bool isSightButtonPressed = false;
  List searchResult = [];
  List festivalResult = [];
  List sightResult = [];

  void shuffleList(List list) {
    var random = Random();
    for (int i = list.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      var temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
  }

  Future<void> fetchRegionInfos(String region) async {
    // final url = Uri.parse('http://ec2-44-223-67-116.compute-1.amazonaws.com:8080/chatbot/get-answer/');
    final url = Uri.parse('http://127.0.0.1:8080/search/get-region-data/');
    final headers = {'Content-Type' : 'application/json'};
    final body = jsonEncode({'region': region});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      setState(() {
        final jsonResponse = jsonDecode(response.body);
        searchResult = jsonResponse['answer'];
        searchResult.forEach((eachResult) {
          if (eachResult['type'] == 'festival') {
            festivalResult.add(eachResult);
          } else {
            sightResult.add(eachResult);
          }
        });
        shuffleList(searchResult);
      });
    } else {
      throw Exception("failed to get region informations");
    }
  }


  @override
  void initState() {
    super.initState();
    fetchRegionInfos(widget.typedLocation);
  }

  @override
  Widget build(BuildContext context) {
    List<CardForm> resultPosts = searchResult.map((eachResult) {
      final title = eachResult['name'];
      final content = eachResult['detail_info'];
      final imageUrl = eachResult['image_url'];

      return CardForm(
        title: title,
        content: content,
        imageUrl: imageUrl,
      );
    }).toList();

    List<CardForm> festivalPosts = festivalResult.map((eachResult) {
      final title = eachResult['name'];
      final content = eachResult['detail_info'];
      final imageUrl = eachResult['image_url'];

      return CardForm(
        title: title,
        content: content,
        imageUrl: imageUrl,
      );
    }).toList();

    List<CardForm> sightPosts = sightResult.map((eachResult) {
      final title = eachResult['name'];
      final content = eachResult['detail_info'];
      final imageUrl = eachResult['image_url'];

      return CardForm(
        title: title,
        content: content,
        imageUrl: imageUrl,
      );
    }).toList();

    List<CardForm> showingPosts = [];
    if (isFestivalButtonPressed) {
      showingPosts = festivalPosts;
    } else if (isSightButtonPressed) {
      showingPosts = sightPosts;
    } else {
      showingPosts = resultPosts;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('"' + widget.typedLocation + '"'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, top: 5),
              child: Text(
                "검색 결과",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  ElevatedButton(
                    style: isFestivalButtonPressed
                        ? ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            // surfaceTintColor: Colors.deepPurpleAccent,
                            foregroundColor: Colors.white,
                        )
                        : ElevatedButton.styleFrom(
                            // backgroundColor: Colors.deepPurpleAccent,
                    ),
                    onPressed: (){
                      isFestivalButtonPressed = !isFestivalButtonPressed;
                      if (isSightButtonPressed) {
                        isSightButtonPressed = !isSightButtonPressed;
                      }
                      setState(() {

                      });
                    },
                    child: Text("축제"),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                    style: isSightButtonPressed
                        ? ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      // surfaceTintColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.white,
                    )
                        : ElevatedButton.styleFrom(
                      // backgroundColor: Colors.deepPurpleAccent,
                    ),
                    onPressed: (){
                      isSightButtonPressed = !isSightButtonPressed;
                      if (isFestivalButtonPressed) {
                        isFestivalButtonPressed = !isFestivalButtonPressed;
                      }
                      setState(() {

                      });
                    },
                    child: Text("명소"),
                  )
                ],
              ),
            ),
            VerticalPostListView(cardForms: showingPosts),
          ],
        ),
      ),
    );
  }
}
