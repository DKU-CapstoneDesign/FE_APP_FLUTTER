import 'package:capstonedesign/model/discover_festival.dart';
import 'package:flutter/material.dart';
import '../../dataSource/discover_dataSource.dart';
import '../../dataSource/fortune_dataSource.dart';
import '../../dataSource/post_dataSource.dart';
import '../../model/fortune.dart';
import '../../model/user.dart';


class HomePageViewModel extends ChangeNotifier {
  List<DiscoverFestival> festivals = [];
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


  // 축제 정보
  Future<void> fetchFestivals() async {
    festivals = (await discoverDatasource.getFestivals())!;
    notifyListeners();
  }

  // 오늘의 운세
  Future<void> getFortune(String birthMonth, String birthDay) async {
    Fortune? fortune = await fortuneDataSource.getFortune(birthMonth, birthDay);
    fortuneToday = fortune!.answer;
    notifyListeners();
  }

  // 가장 최근 게시물
  Future<void> getPostList(User user) async {
    posts = (await postDataSource.getAllPost(user))!;
    notifyListeners();
  }


}