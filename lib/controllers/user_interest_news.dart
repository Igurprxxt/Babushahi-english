import '../base_url.dart';
import 'package:dio/dio.dart';
import '../boxes.dart';
import '../models/news.dart';
import 'package:intl/intl.dart';

class UserInterestNews {
  static int _compareDates(String date1, String date2) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final parsedDate1 = dateFormat.parse(date1);
    final parsedDate2 = dateFormat.parse(date2);
    return parsedDate2.compareTo(parsedDate1);
  }

  static Future<List<News>> fetch() async {
    print('UserInterestNews fetch function called at: ${DateTime.now()}');
    // This method returns all the news according to user interest, (user interest is chosen by user when the app is first launched)
    final dio = Dio();
    List<News> allNews = <News>[];
    List<Future<Response>> apiCallFutures = [];

    for (var element in Boxes.getInterestBox().values.toList()) {
      try {
        apiCallFutures.add(dio.get(
          '${BaseUrl.apiUrl}/newsbycategory.php?secretkey=6kubnU4)53ez&category=${element.name}',
        ));
      } catch (e) {
        print('e' + e.toString());
      }
    }
    // Wait for all the API calls to complete
    List<Response> apiCallResponses = await Future.wait(apiCallFutures);
    for (var response in apiCallResponses) {
      if (response.statusCode == 200) {
        final data = response.data;
        // Adding current category news to an array
        allNews.addAll(data.map<News>((json) => News.fromJson(json)).toList());
      } else {
        // Print which data is not fetched
        print("Status code is non 200: ${response.statusCode}");
      }
    }
    var ads = [];
    print("all news length: " + allNews.length.toString());
    // add ads to the ads array
    allNews.forEach((element) {
      if (element.type == 'ads') {
        ads.add(element);
      }
    });
    print("ads length: " + ads.length.toString());
    // Removing ads from the allNews array and adding it to ads array
    allNews.removeWhere((element) => element.type == 'ads');

    // keep at most 1 news with a unique id, remove all other news with same id
    List<News> uniqueNewsList = [];
    allNews.forEach((element) {
      if (uniqueNewsList.length == 0) {
        uniqueNewsList.add(element);
      } else {
        bool isPresent = false;
        for (var i = 0; i < uniqueNewsList.length; i++) {
          if (uniqueNewsList[i].id == element.id) {
            isPresent = true;
            break;
          }
        }
        if (!isPresent) {
          uniqueNewsList.add(element);
        }
      }
    });
    print("unique news list length: " + uniqueNewsList.length.toString());
    // Filter news according to latest posted on
// Calculate the current date, yesterday, and one day before yesterday
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 2));
    // final dayBeforeYesterday = now.subtract(Duration(days: 2));

// // Filter the news to include those from today, yesterday, and one day before yesterday
    uniqueNewsList = uniqueNewsList.where((news) {
      final postedOnDate = DateFormat('MMM dd, yyyy').parse(news.postedon!);
      return postedOnDate.isAfter(yesterday) && postedOnDate.isBefore(now);
    }).toList();

//checking duplicate id
    uniqueNewsList.sort((a, b) => _compareDates(a.postedon!, b.postedon!));
    for (var element in uniqueNewsList) {
      print(element.id);
    }
    return uniqueNewsList;
  }
}
