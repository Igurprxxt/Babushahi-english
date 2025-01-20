import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/news.dart';
import '../screens/web_view_screen.dart';

Widget newsSlider({required List<News> data, required BuildContext context}) {
  // All the news url are not http, so converting them to https
  String convertToHttps(String url) {
    if (url.startsWith('http://')) {
      // Replace 'http://' with 'https://'
      return url.replaceFirst('http://', 'https://');
    }
    // URL is already using HTTPS, return as is
    return url;
  }

  Future<void> _openFullNews(
      {required String url, required BuildContext context}) async {
    // Navigating to the FullNews screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FullNews(url: url, isNotification: false),
      ),
    );
  }

  return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (_, i) {
        if (data[i].type == 'news') {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  _openFullNews(
                      url: convertToHttps(data[i].pageUrl!), context: _);
                },
                onLongPress: () {
                  Share.share(
                      '${data[i].headline}. Read full news here ${data[i].pageUrl}');
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 300,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // Showing default image if the news doesn't have an image
                    image: data[i].photo == null
                        ? const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/default_news_image.jpeg',
                            ),
                          )
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              data[i].photo!,
                            ),
                          ),
                  ),
                  child: const SizedBox(),
                ),
              ),
              Container(
                width: 300,
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  data[i].headline ?? 'No headline',
                  textAlign: TextAlign.left,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          );
        } else if (data[i].type == 'ads') {
          return const SizedBox();
        } else {
          return const Text("Error");
        }
      });
}
