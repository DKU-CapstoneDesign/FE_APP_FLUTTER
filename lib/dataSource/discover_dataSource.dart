import 'package:capstonedesign/model/discover_advertisement.dart';
import 'package:capstonedesign/model/discover_festival.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/discover_sight.dart';


class DiscoverDatasource {
  String baseUrl= 'http://144.24.81.41:8080'; // 예비 서버

  //////축제 가져오기
  Future<List<DiscoverFestival>?> getFestivals() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/festival/get-festivals/'),
        headers: {
          'Accept': 'application/json; charset=utf-8',
        },
      );
    if (response.statusCode == 200) {
      print("축제 가져오기 성공");
      final List<dynamic> festivalsJson = jsonDecode(utf8.decode(response.bodyBytes));
      // Festival 객체로 변환하여 반환;
      return festivalsJson.map((json) => DiscoverFestival.fromJson(json)).toList();
    } else {
      print("축제 가져오기 실패: : ${response.body}");
      return null;
    }
    } catch(e){
      print('오류 발생: $e');
    }
  }

  //////명소 가져오기
  Future<List<DiscoverSight>?> getSights() async {
    try{
      final response = await http.get(
        Uri.parse('$baseUrl/sight/get-sights/'),
        headers: {
          'Accept': 'application/json; charset=utf-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> sightJson = jsonDecode(utf8.decode(response.bodyBytes));
        // Sights 객체로 변환하여 반환;
        return sightJson.map((json) => DiscoverSight.fromJson(json)).toList();
      } else {
        print("명소 가져오기 실패: : ${response.body}");
        return null;
      }
    } catch(e){
      print('오류 발생: $e');
    }
  }


  //////쇼핑 가져오기
  Future<List<DiscoverAdvertisement>?> getAdvertise() async {
    try{
      final response = await http.get(
        Uri.parse('$baseUrl/advertise/get-advertisements/'),
        headers: {
          'Accept': 'application/json; charset=utf-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> sightJson = jsonDecode(utf8.decode(response.bodyBytes));
        // Advertise 객체로 변환하여 반환;
        return sightJson.map((json) => DiscoverAdvertisement.fromJson(json)).toList();
      } else {
        print("쇼핑 가져오기 실패: : ${response.body}");
        return null;
      }
    } catch(e){
      print('오류 발생: $e');
    }
  }
}