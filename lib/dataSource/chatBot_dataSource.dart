import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatBotDataSource {
  final String baseUrl = 'https://api.koreigner.o-r.kr';


  Future<String?> getChatBotResponse(String message) async{
    try{
      final response = await http.post(
        Uri.parse('$baseUrl/chatbot/get-answer/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'query': message}),
      );
      if (response.statusCode == 200) {
        print("챗봇 성공");
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['answer'];
      } else {
        print("챗봇 가져오기 실패 : : ${response.body}");
        return null;
      }
    } catch(e){
      print('오류 발생: $e');
    }
  }
}