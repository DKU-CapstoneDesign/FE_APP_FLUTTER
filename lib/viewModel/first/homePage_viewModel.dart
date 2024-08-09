// viewmodels/home_view_model.dart

import 'package:flutter/material.dart';
import '../../dataSource/cardForm_dataSource.dart';
import '../../dataSource/fortune_dataSource.dart';
import '../../model/cardForm.dart';
import '../../model/fortune.dart';


class HomeViewModel extends ChangeNotifier {
  List<CardForm> festivals = [];
  String fortuneToday = '';
  final CardFormDatasource  cardFormDatasource;
  final FortuneDataSource fortuneDataSource;

  HomeViewModel({
    required this.cardFormDatasource,
    required this.fortuneDataSource,
  });

  Future<void> fetchFestivals() async {
    try {
      festivals = await cardFormDatasource.fetchFestivals();
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