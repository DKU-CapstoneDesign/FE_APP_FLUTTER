// data/festival_datasource.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/cardForm.dart';


class CardFormDatasource {
  final String baseUrl= 'http://127.0.0.1:8080';

  CardFormDatasource ();

  Future<List<CardForm>> fetchFestivals() async {
    final response = await http.get(
      Uri.parse('$baseUrl/festival/get-festivals/'),
      headers: {
        'Accept': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> festivalsJson = jsonDecode(utf8.decode(response.bodyBytes));
      return festivalsJson.map((json) => CardForm.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load festivals');
    }
  }
}