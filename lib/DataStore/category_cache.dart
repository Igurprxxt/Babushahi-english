import 'package:flutter/material.dart';
import '../controllers/category_news.dart';

class CategoryNewsDataCache {
  final Map<String, dynamic> _cache = {};
  DateTime lastRequest = DateTime.now();
  Future<void> clearCache() async {
    print("Cache cleared");
    _cache.clear();
  }

  Future<dynamic> getData(
    String key,
    BuildContext context,
  ) async {
    // print(_cache);
    if (_cache.containsKey(key)) {
      // If data is already in the cache, return it
      return _cache[key];
    } else {
      // Fetch the data and store it in the cache
      final data = await CategoryNews.fetch(key, context);
      _cache[key] = data;
      return data;
    }
  }
}
