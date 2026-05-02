import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {

  static const String apiKey = "YOUR_API_KEY_HERE";

  static Future<List<dynamic>> fetchNews() async {

    final url = Uri.parse(
      "https://newsapi.org/v2/everything?"
      "q=ethiopia%20election%20OR%20ethiopia%20politics%20OR%20ethiopian%20parliament"
      "&language=en"
      "&sortBy=publishedAt"
      "&apiKey=$apiKey"
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {

      final data = json.decode(response.body);

      return data["articles"];

    } else {
      throw Exception("Failed to load Ethiopia news");
    }
  }
}