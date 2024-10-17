import 'package:flutter/material.dart';
import '../../dataSource/discover_dataSource.dart';

class DiscoverViewModel extends ChangeNotifier {
  DiscoverDatasource datasource = DiscoverDatasource();
  // 이미지만 들고 옴
  List<String> allImage = [];
  List<String> festivalImage = [];
  List<String> sightImage = [];
  List<String> advertiseImage = [];

  DiscoverViewModel(DiscoverDatasource discoverDatasource);

  //// discover 이미지 들고오기
  Future<void> fetchAllPosts() async {
    final festivals = await datasource.getFestivals();
    final sights = await datasource.getSights();
    final advertises = await datasource.getAdvertise();

    // image_url만 각 리스트에 저장
    festivalImage = festivals!.map((item) => item.image_url).toList();
    sightImage = sights!.map((item) => item.image_url).toList();
    advertiseImage = advertises!.map((item) => item.image_url).toList();

    // 모든 image_url을 합쳐서 allImage에 저장 후, 랜덤하게 섞음
    allImage = [...festivalImage, ...sightImage, ...advertiseImage];
    allImage.shuffle(); //랜덤
    notifyListeners();
  }

  // 토글 클릭 시 필터링
  List<String> filteredDiscoverPosts(String category) {
    if (category == 'festival') {
      return festivalImage;
    } else if (category == 'sight') {
      return sightImage;
    } else if (category == 'advertise') {
      return advertiseImage;
    } else {
      return allImage;
    }
  }

  /// Get category of an image
  String getImageCategory(String imageUrl) {
    if (festivalImage.contains(imageUrl)) {
      return 'festival';
    } else if (sightImage.contains(imageUrl)) {
      return 'sight';
    } else if (advertiseImage.contains(imageUrl)) {
      return 'advertise';
    } else {
      return 'unknown'; // If not found
    }
  }

  //// 지역 검색
  Future<void> searchDiscover() async {
    final festivals = await datasource.getFestivals();
    final sights = await datasource.getSights();
    final advertises = await datasource.getAdvertise();

    // image_url만 각 리스트에 저장
    festivalImage = festivals!.map((item) => item.image_url).toList();
    sightImage = sights!.map((item) => item.image_url).toList();
    advertiseImage = advertises!.map((item) => item.image_url).toList();

    // 모든 image_url을 합쳐서 allImage에 저장 후, 랜덤하게 섞음
    allImage = [...festivalImage, ...sightImage, ...advertiseImage];
    allImage.shuffle(); //랜덤
    notifyListeners();
  }
}