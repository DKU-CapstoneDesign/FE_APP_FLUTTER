import 'package:flutter/material.dart';
import '../../dataSource/discover_dataSource.dart';

class DiscoverViewModel extends ChangeNotifier {
  DiscoverDatasource datasource;
  bool loading = false;

  List<dynamic> festivals = [];
  List<dynamic> sights = [];
  List<dynamic> advertises = [];

  List<dynamic> allItems = []; // This will store all items (festivals, sights, advertises)

  DiscoverViewModel({required this.datasource});

  Future<void> getAllPosts() async {
    loading = true;
    notifyListeners();

    festivals = (await datasource.getFestivals()) ?? [];
    sights = (await datasource.getSights()) ?? [];
    advertises = (await datasource.getAdvertise()) ?? [];

    // Combine all items into a single list
    allItems = [...festivals, ...sights, ...advertises];
    allItems.shuffle(); // Optional: shuffle the items

    loading = false;
    notifyListeners();
  }

  /// Filter items by category
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

  /// Get category of an image
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