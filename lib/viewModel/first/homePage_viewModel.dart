import 'package:flutter/material.dart';
import '../../dataSource/discover_dataSource.dart';
import '../../dataSource/fortune_dataSource.dart';
import '../../dataSource/post_dataSource.dart';
import '../../model/discover.dart';
import '../../model/fortune.dart';
import '../../model/user.dart';


class HomePageViewModel extends ChangeNotifier {
  List<Discover> festivals = [];
  String fortuneToday = '';
  List<dynamic> posts = [];
  final DiscoverDatasource discoverDatasource;
  final FortuneDataSource fortuneDataSource;
  final PostDataSource postDataSource;

  HomePageViewModel({
    required this.discoverDatasource,
    required this.fortuneDataSource,
    required this.postDataSource,
  });

  Future<void> fetchFestivals() async {
    try {
      festivals = (await discoverDatasource.fetchFestivals())!;
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> getFortune(String birthMonth, String birthDay) async {
    try {
      Fortune fortune = await fortuneDataSource.getFortune(birthMonth, birthDay);
      fortuneToday = fortune.answer;
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  // 게시물 목록 가져오기
  Future<void> getPostList(User user) async {
    posts = (await postDataSource.getAllPost(user))!;
    print("1111111$posts");
    notifyListeners();
  }

  void loadInitialData() {
    fetchFestivals();
    getFortune('1', '22');
  }
}