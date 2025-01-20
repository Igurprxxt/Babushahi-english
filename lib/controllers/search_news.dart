import '../base_url.dart';
import 'package:dio/dio.dart';
import '../models/news.dart';

class SearchNews {
  static Future<List<News>> fetch(String searchKeyword) async {
    // This method returns att the news in the given category
    final dio = Dio();
    late final List<News> news;
    try {
      final response = await dio.get(
          '${BaseUrl.apiUrl}/searchnews.php?secretkey=6kubnU4)53ez&text=$searchKeyword');
      if (response.statusCode == 200) {
        final data = response.data;
        news = data.map<News>((json) => News.fromJson(json)).toList();
        return news;
      } else {
        // TODO: Handle this error
        print('200 nhi aay bro');
        throw Exception('Failed to load news, non-200 status code');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load news, failed to make API call');
    }
  }
}
