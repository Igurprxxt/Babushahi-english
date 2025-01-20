import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../base_url.dart';
import '../models/news.dart';

class CategoryNews {
  static Future<List<News>> fetch(
    String category,
    BuildContext context,
  ) async {
    // This method returns all the news in the given category
    final dio = Dio();
    late final List<News> news;
    try {
      print("Url is :" +
          '${BaseUrl.apiUrl}/$category.php?secretkey=6kubnU4)53ez');
      final response = await dio
          .get('${BaseUrl.apiUrl}/$category.php?secretkey=6kubnU4)53ez');
      if (response.statusCode == 200) {
        final data = response.data;
        news = data.map<News>((json) => News.fromJson(json)).toList();
        print(news.length.toString() + "lenhh");
        if (category == 'currentnews') {
          // Keep news for the last 2 days only, news format Aug 07, 2023
          final now = DateTime.now();
          final dateFormat = DateFormat('MMM dd, yyyy');

          news.retainWhere((element) {
            try {
              final parsedDate = dateFormat.parse(element.postedon!);
              final difference = now.difference(parsedDate).inDays;
              return difference <= 1; // Keep news from today and yesterday.
            } catch (e) {
              return false;
            }
          });
        }

        print(news.length);
        news.forEach((element) {
          print(element.postedon);
        });
        return news;
      } else {
        print('200 nhi aay bro');
        throw Exception('Failed to load news, non 200 status code');
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Server down. Please try again in a few minutes.'),
        ),
      );
      throw Exception('Failed to load news, failed to make API call');
    }
  }
}
