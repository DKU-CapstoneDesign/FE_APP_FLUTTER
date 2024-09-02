// viewmodels/home_view_model.dart

import 'package:flutter/material.dart';
import '../../dataSource/discover_dataSource.dart';
import '../../dataSource/fortune_dataSource.dart';
import '../../model/discover.dart';
import '../../model/fortune.dart';


class HomeViewModel extends ChangeNotifier {
  List<Discover> festivals = [];
  String fortuneToday = '';
  final DiscoverDatasource discoverDatasource;
  final FortuneDataSource fortuneDataSource;

  HomeViewModel({
    required this.discoverDatasource,
    required this.fortuneDataSource,
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

  void loadInitialData() {
    fetchFestivals();
    getFortune('1', '22');
  }
}