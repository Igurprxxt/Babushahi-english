import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/news.dart';
import '../screens/web_view_screen.dart';

Widget newsList(List<News> data) {
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
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (_, i) {
        if (data[i].type == 'news') {
          return GestureDetector(
            onTap: () {
              _openFullNews(url: convertToHttps(data[i].pageUrl!), context: _);
            },
            onLongPress: () {
              Share.share(
                  '${data[i].headline}. Read full news here ${data[i].pageUrl}');
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListTile(
                  leading: Container(
                    width: 80,
                    height: 180,
                    decoration: BoxDecoration(
                      // color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      // Showing default image if the news doesn't have an image
                      image: data[i].photo == null
                          ? const DecorationImage(
                              image: AssetImage(
                                'assets/images/default_news_image.jpeg',
                              ),
                            )
                          : DecorationImage(
                              scale: 5,
                              image: NetworkImage(
                                data[i].photo!,
                              ),
                            ),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 4, horizontal: 8),
                      //   decoration: BoxDecoration(
                      //     color: const Color(0XFFE8ECF0),
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: Text(
                      //     data[i].category ?? 'Uncategorized',
                      //     style: const TextStyle(
                      //       fontSize: 9,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          data[i].headline ?? 'No headline',
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset(
                                'assets/images/babushahi-icon-english.png',
                                height: 16,
                                width: 16,
                              ),
                            ),
                            const Text(
                              'Babushahi Bureau',
                              style: TextStyle(
                                fontSize: 10,
                                // fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // TODO: Change static time to real data
                            Text(
                              data[i].postedon ?? 'Unknown',
                              style: const TextStyle(
                                fontSize: 8,
                                // fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          );
        } else if (data[i].type == 'ads') {
          // return const Text('Ad Space');
          return const SizedBox();
        } else {
          return const Text("Error");
        }
      });
}
