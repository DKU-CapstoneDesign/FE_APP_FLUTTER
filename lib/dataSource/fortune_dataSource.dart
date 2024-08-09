// data/fortune_datasource.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/fortune.dart';


class FortuneDataSource {
  final String baseUrl= 'http://127.0.0.1:8080';

  FortuneDataSource();

  Future<Fortune> getFortune(String birthMonth, String birthDay) async {
    final url = Uri.parse('$baseUrl/fortune/get-fortune/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'birth_month': birthMonth, 'birth_day': birthDay});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return Fortune.fromJson(jsonResponse);
    } else {
      throw Exception("Failed to get fortune response");
    }
  }
}