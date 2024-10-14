import 'package:capstonedesign/dataSource/discover_dataSource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';


class DiscoverDetailViewModel extends ChangeNotifier {
  late DiscoverDatasource datasource;

  // 축제 가져오기
  Future<void> getFestivals() async {
    final festival = await datasource.getFestivals();
  }

  // 명소 가져오기
  Future<void> getSights() async {
    final sights = await datasource.getSights();
  }

  // 쇼핑 가져오기
  Future<void> getAdvertise() async {
    final advertise = await datasource.getAdvertise();
  }

}