import 'package:flutter/material.dart';
import '../../dataSource/discover_dataSource.dart';

class DiscoverViewModel extends ChangeNotifier {
  DiscoverDatasource datasource;
  bool loading = false;

  List<dynamic> festivals = [];
  List<dynamic> sights = [];
  List<dynamic> advertises = [];
  List<dynamic> allItems = [];  // 다 보여주는 리스트

  DiscoverViewModel({required this.datasource});

  Future<void> getAllPosts() async {
    loading = true;
    notifyListeners();

    festivals = (await datasource.getFestivals()) ?? [];
    sights = (await datasource.getSights()) ?? [];
    advertises = (await datasource.getAdvertise()) ?? [];

    //가져온 것들 합쳐서 리스트에 넣기
    allItems = [...festivals, ...sights, ...advertises];
    allItems.shuffle(); // 랜덤하게 (shuffle)

    loading = false;
    notifyListeners();
  }

  // 보여주는 것 필터링
  List<dynamic> filteredDiscoverPosts(String category) {
    if (category == 'festival') {
      return festivals;
    } else if (category == 'sight') {
      return sights;
    } else if (category == 'advertise') {
      return advertises;
    } else {
      return allItems;
    }
  }

  // 보여주는 것 필터링
  String getItemCategory(dynamic item) {
    if (festivals.contains(item)) {
      return 'festival';
    } else if (sights.contains(item)) {
      return 'sight';
    } else if (advertises.contains(item)) {
      return 'advertise';
    } else {
      return 'unknown';
    }
  }
}