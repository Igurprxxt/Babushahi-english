import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget homeLoadingWidget() {
  return Scaffold(
      body: Container(
    width: 10000,
    height: 10000,
    decoration: const BoxDecoration(color: Color(0xffF3FAE7)),
    child: Image.asset(
      "assets/images/splash.gif",
      height: 500.0,
      width: 500.0,
    ),
  ));
}

Widget newsTopLoadingWidget() {
  return Shimmer.fromColors(
    baseColor: Colors.grey,
    highlightColor: Colors.white,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (_, i) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 300,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                image: AssetImage(
                  'assets/images/default_news_image.jpeg',
                ),
              ),
            ),
            child: ListTile(
              title: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: const Color(0XFFE8ECF0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Top News',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 1),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0, right: 40.0),
                    child: Text(
                      'Babushahi Media News',
                      textAlign: TextAlign.left,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
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
                            color: Colors.white,
                            fontSize: 10,
                            // fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
  );
}

Widget newsListLoadingWidget() {
  // This widget is used to show the loading animation for the news list
  return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (_, i) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListTile(
                  leading: Container(
                    height: 100,
                    width: 100,
                    // Have to keep the image below, else the shimmer effect won't work
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // Showing default image if the news doesn't have an image
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/default_news_image.jpeg',
                          ),
                        )),
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
                      //     'Uncategorized',
                      //     style: const TextStyle(
                      //       fontSize: 9,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Babushahi Media News',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 12,
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
                              '  ',
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
                ));
          }));
}
