import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  static const String apiKey = '47d5376ba95b47a49ad53edb38eeacda';
  static const String baseUrl = 'https://newsapi.org/v2/top-headlines';

  static Future<List<dynamic>> fetchNews(String category) async {
    final url = '$baseUrl?country=us&category=$category&apiKey=$apiKey';
    print('🟢 Fetching: $url');

    final response = await http.get(Uri.parse(url));
    print('🔵 Status Code: ${response.statusCode}');

    try {
      final body = response.body;
      print('🟡 Body: ${body.substring(0, 500)}'); // first 500 chars

      if (response.statusCode == 200) {
        final data = json.decode(body);
        final articles = data['articles'];
        print('📦 Articles fetched: ${articles.length}');
        return articles;
      } else {
        throw Exception('❌ Failed with status ${response.statusCode}');
      }
    } catch (e) {
      print('🔥 Error decoding JSON: $e');
      return []; // fallback to avoid crash
    }
  }


}
