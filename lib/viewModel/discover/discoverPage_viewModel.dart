import 'package:flutter/material.dart';
import '../../dataSource/discover_dataSource.dart';
import '../../view/screens/discover/discoverPage.dart';

class DiscoverViewModel extends ChangeNotifier {
  final DiscoverDatasource datasource;
  bool loading = false;

  List<dynamic> festivals = [];
  List<dynamic> sights = [];
  List<dynamic> advertises = [];
  List<dynamic> allItems = [];  // 다 보여주는 리스트
  List<dynamic> searchResults = []; // 검색 결과 리스트

  DiscoverViewModel({required this.datasource});

  Future<void> getAllPosts() async {
    loading = true;
    notifyListeners();

    festivals = (await datasource.getFestivals()) ?? [];
    sights = (await datasource.getSights()) ?? [];
    advertises = (await datasource.getAdvertise()) ?? [];

    // 가져온 것들 합쳐서 리스트에 넣기
    allItems = [...festivals, ...sights, ...advertises];
    allItems.shuffle(); // 랜덤하게 (shuffle)

    searchResults = [];// 검색 결과 초기화
    loading = false;
    notifyListeners();
  }

  // 카테고리별로 게시물 필터링
  List<dynamic> filteredDiscoverPosts(DiscoverCategory category) {
    if (searchResults.isNotEmpty) {
      return allItems; // 검색 결과가 있는 경우 전체 목록 반환
    } else {
      // 검색 결과가 없을 때만 카테고리 필터링 적용
      switch (category) {
        case DiscoverCategory.festival:
          return festivals;
        case DiscoverCategory.sight:
          return sights;
        case DiscoverCategory.advertise:
          return advertises;
        case DiscoverCategory.all:
          return allItems;
      }
    }
  }

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

  // 검색 기능
  Future<void> searchDiscover(String region, BuildContext context) async {
    loading = true;
    notifyListeners();

    List<dynamic> filteredFestivals = festivals.where((item) {
      return item.address?.contains(region) ?? false;
    }).toList();

    List<dynamic> filteredSights = sights.where((item) {
      return item.address?.contains(region) ?? false;
    }).toList();

    searchResults = [...filteredFestivals, ...filteredSights];

    if (searchResults.isEmpty) {
      _showNoResultsDialog(context);
    }

    loading = false;
    notifyListeners();
  }

  // 검색 후 결과가 없을 때 보여주는 다이얼로그
  void _showNoResultsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('죄송합니다'),
          content: const Text('찾으시는 정보가 없습니다!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}