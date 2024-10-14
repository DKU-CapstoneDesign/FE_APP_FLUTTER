import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/fortune.dart';


class FortuneDataSource {
  final String baseUrl= 'http://144.24.81.41:8080'; // 예비 서버

  Future<Fortune> getFortune(String birthMonth, String birthDay) async {
    final url = Uri.parse('$baseUrl/fortune/get-fortune/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'birth_month': birthMonth, 'birth_day': birthDay});
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return Fortune.fromJson(jsonResponse);
    } else {
      throw Exception("운세 가져오기 실패");
    }
  }
}