import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  final String apiKey = 'YOUR_AZURE_API_KEY';
  final String endpoint = 'https://api.cognitive.microsofttranslator.com';
  final String location = 'YOUR_RESOURCE_LOCATION'; // ex: koreacentral

  Future<String> translate(String text, String toLanguage) async {
    final url = Uri.parse('$endpoint/translate?api-version=3.0&to=$toLanguage');
    final headers = {
      'Ocp-Apim-Subscription-Key': apiKey,
      'Ocp-Apim-Subscription-Region': location,
      'Content-Type': 'application/json'
    };

    final body = jsonEncode([{'Text': text}]);

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data[0]['translations'][0]['text'];
    } else {
      throw Exception('번역 : ${response.statusCode}');
    }
  }
}
