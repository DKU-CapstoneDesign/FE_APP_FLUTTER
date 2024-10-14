import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatBotDataSource {
  final String _baseUrl = 'http://ec2-44-223-67-116.compute-1.amazonaws.com:8080';

  Future<String> getChatBotResponse(String message) async {
    final url = Uri.parse('$_baseUrl/chatbot/get-answer/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'query': message});
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['answer'];
    } else {
      throw Exception("챗봇 가져오기 실패 : ${response.body}");
    }
  }
}