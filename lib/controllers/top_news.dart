import 'package:flutter/material.dart';

import '../base_url.dart';
import 'package:dio/dio.dart';
import '../models/news.dart';

class TopNews {
  static Future<List<News>> fetch(BuildContext context) async {
    // This method returns the top news
    final dio = Dio();
    late final List<News> news;
    try {
      final response =
          await dio.get('${BaseUrl.apiUrl}/topnews.php?secretkey=6kubnU4)53ez');
      if (response.statusCode == 200) {
        final data = response.data;
        news = data.map<News>((json) => News.fromJson(json)).toList();
        return news;
      } else {
        // TODO: Handle this error
        print('200 nhi aay bro');
        throw Exception('Failed to load news, non 200 status code');
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('server down please try in few minutes'),
        ),
      );
      throw Exception('Failed to load news, failed to make API call');
    }
  }
}
