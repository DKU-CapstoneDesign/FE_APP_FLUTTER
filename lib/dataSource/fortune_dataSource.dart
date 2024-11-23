import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/fortune.dart';


class FortuneDataSource {
  final String baseUrl= 'http://144.24.81.41:80';

  Future<Fortune?> getFortune(String birthMonth, String birthDay) async{
    try{
      final response = await http.post(
        Uri.parse('$baseUrl/fortune/get-fortune/'),
        headers: {'Content-Type': 'application/json'},
        body:  jsonEncode({'birth_month': birthMonth, 'birth_day': birthDay}),
      );
      if (response.statusCode == 200) {
        print("운세 가져오기 성공");
        final jsonResponse = jsonDecode(response.body);
        return Fortune.fromJson(jsonResponse);
      } else {
        print("운세 가져오기 실패 : : ${response.body}");
        return null;
      }
    } catch(e){
      print('오류 발생: $e');
    }
  }
}