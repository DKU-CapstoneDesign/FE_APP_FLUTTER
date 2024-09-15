import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/discover.dart';


class DiscoverDatasource {
  String baseUrl= 'http://127.0.0.1:8080';

  //////축제 가져오기
  Future<List<Discover>?> fetchFestivals() async {
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
      // User 객체로 변환하여 반환;
      return festivalsJson.map((json) => Discover.fromJson(json)).toList();
    } else {
      print("축제 가져오기 실패: : ${response.body}");
      return null;
    }
    } catch(e){
      print('오류 발생: $e');
    }
  }

  //////명소 가져오기
  Future<List<Discover>?> fetchSights() async {
    try{
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8080/sight/get-sights/'),
        headers: {
          'Accept': 'application/json; charset=utf-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> sightJson = jsonDecode(utf8.decode(response.bodyBytes));
        return sightJson.map((json) => Discover.fromJson(json)).toList();
      } else {
        print("명소 가져오기 실패: : ${response.body}");
        return null;
      }
    } catch(e){
      print('오류 발생: $e');
    }

  }

}