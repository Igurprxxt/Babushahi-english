// This is the main page where the user can see the news feed.

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../DataStore/category_cache.dart';
import '../controllers/search_news.dart';
import '../controllers/top_news.dart';
import '../controllers/user_interest_news.dart';
import '../models/news.dart';
import '../news_categories.dart';
import '../widgets/loading.dart';
import '../widgets/news_list.dart';
import '../widgets/news_slider.dart';
import '../news_categories.dart' as newsCategories;
import 'menu.dart';
import 'dart:async';

// Creating cache Outside the class to avoid reinitialization on every build
final CategoryNewsDataCache cache = CategoryNewsDataCache();

class HomePage extends StatefulWidget {
  final newTabIndex;
  const HomePage({super.key, this.newTabIndex});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // generate tabs form global data file
  List<Tab> topTabs = newsCategories.tabBarHeaders();

  List<Widget> _tabBarViewTabs = newsCategories.tabBarViews();
  // isSearching is used to show the search bar in the app bar instead of the tab bar
  bool isSearching = false;
  // showSearchResults is used to show the search results in the personalized news tab
  // bool showSearchResults = false;

  Future<void> _openSocials(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  late final _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 16,
      vsync: this,
    );
    const oneSec = Duration(seconds: 200);
    Timer.periodic(oneSec, (Timer t) {
      print('Timer chal rha hai');
      cache.clearCache();
      // Clearing whole state as the top slider is not cached
      setState(() {
        _HomePageState;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.newTabIndex != null) {
      // Check if the tab index is -1
      if (widget.newTabIndex != -1) {
        // Doing this to avoid the error of tab index out of range, although this error must not occur
      }

      if (_tabController.index < topTabs.length - 1) {
        // Scroll to the next tab
        _tabController.animateTo(widget.newTabIndex);
      }
    } else {
      // print("null aaya");
    }
    return DefaultTabController(
      initialIndex: 0,
      length: 16,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffE8ECF0),
          toolbarHeight: 100,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/babushahi-icon-english.png',
                    height: 40,
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      _openSocials(
                          'https://www.facebook.com/BabushahiDotCom?mibextid=ZbWKwL');
                    },
                    child: Image.asset(
                      'assets/images/facebook_logo.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _openSocials(
                          'https://youtube.com/@BabushahiTimesNetwork');
                    },
                    child: Image.asset(
                      'assets/images/youtube_logo.png',
                      height: 50,
                      width: 50,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _openSocials(
                          'https://twitter.com/Babushahikhabar?t=vmvHfBOTjZ7Q0JQPueyFVw&s=09');
                    },
                    child: Image.asset(
                      'assets/images/twitter_logo.png',
                      height: 27,
                      width: 27,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _openSocials(
                          'https://www.instagram.com/invites/contact/?i=1szcho49tfws8&utm_content=hfkvq2y');
                    },
                    child: Image.asset(
                      'assets/images/instagram_logo.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _openSocials('https://t.me/babushahitimes');
                    },
                    child: Image.asset(
                      'assets/images/telegram_logo.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _openSocials(
                          'https://www.linkedin.com/in/baljit-balli-69017b20');
                    },
                    child: Image.asset(
                      'assets/images/linkedin_logo.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Add link to Babushahi Punjabi app
                    },
                    child: Image.asset(
                      'assets/images/babushahi-icon-punjabi.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                ],
              ),
              Container(
                width: 160,
                height: 30,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      _openSocials('https://www.babushahihindi.com');
                    },
                    child: Image.asset(
                      'assets/images/babushahi_hindi.gif',
                      width: 160,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              )
            ],
          ),
          bottom: AppBar(
            elevation: 0,
            bottomOpacity: 0,
            backgroundColor: const Color(0xffE8ECF0),
            title: isSearching
                ? TextField(
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Search Keyword',
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _tabController.index = 0;
                          _tabBarViewTabs =
                              newsCategories.tabBarViews(searchKeyword: value);
                        });
                      }
                    },
                  )
                : TabBar(
                    controller: _tabController,
                    tabs: topTabs,
                    isScrollable: true,
                    indicatorColor: const Color(0xff1A52C2),
                    labelColor: const Color(0xff1A52C2),
                    unselectedLabelColor: const Color(0xffE31D1D),
                  ),
            leading: isSearching
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = false;
                        _tabBarViewTabs = newsCategories.tabBarViews();
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  )
                : IconButton(
                    color: Colors.black,
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const Menu()));
                    },
                  ),
            actions: [
              IconButton(
                onPressed: () {
                  if (_tabController.index < topTabs.length - 1) {
                    _tabController.animateTo(_tabController.index + 1);
                  }
                },
                iconSize: 20,
                splashRadius: 30,
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black,
                ),
              ),
              IconButton(
                color: Colors.black,
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    isSearching = true;
                  });
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            isSearching
                ? const SizedBox()
                : Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 245,
                    child: FutureBuilder<List<News>>(
                        future: TopNews.fetch(context),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // print(snapshot.data);
                            return newsSlider(
                                context: context, data: snapshot.data!);
                          }
                          if (snapshot.hasError) {
                            return const Text('An Unexpected error Occurred');
                          } else {
                            // Showing Shimmer loading effect while fetching data from API
                            return newsTopLoadingWidget();
                          }
                        }),
                  ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _tabBarViewTabs,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  // This Widget shows User preference news (Personalized news)
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _HomePageState;
        });
      },
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<News>>(
                future: UserInterestNews.fetch(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return newsList(snapshot.data!);
                  }
                  if (snapshot.hasError) {
                    return const Text('An Unexpected error Occurred');
                  } else {
                    return newsListLoadingWidget();
                    // return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class CategoryHomeTab extends StatefulWidget {
  // This Widget shows
  // - category wise news (category to be passed as a param)
  const CategoryHomeTab({super.key, required this.newsCategory});
  final String newsCategory;
  @override
  State<CategoryHomeTab> createState() => _CategoryHomeTabState();
}

class _CategoryHomeTabState extends State<CategoryHomeTab> {
  @override
  Widget build(BuildContext context) {
    String _getNewsCategoryFullName(name) {
      // This method return the user friendly and readable name of the category
      return newsChoices.entries
          .firstWhere((element) => element.value == name)
          .key;
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _HomePageState;
        });
      },
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getNewsCategoryFullName(widget.newsCategory),
                  style: const TextStyle(
                    color: Color(0xffE31D1D),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: cache.getData(widget.newsCategory, context),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return newsList(snapshot.data!);
                  }
                  if (snapshot.hasError) {
                    return const Text('An Unexpected error Occurred');
                  } else {
                    return newsListLoadingWidget();
                    // return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class SearchTab extends StatefulWidget {
  const SearchTab(this.searchKeyword, {super.key});
  final String searchKeyword;

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search Results',
                style: TextStyle(
                  color: Color(0xffE31D1D),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<News>>(
              future: SearchNews.fetch(widget.searchKeyword),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.isNotEmpty) {
                    // Changing tab index to search tab
                    return newsList(snapshot.data!);
                  }
                  return Text('No news found for "${widget.searchKeyword}"');
                }
                if (snapshot.hasError) {
                  return const Text('An Unexpected error Occurred');
                } else {
                  return newsListLoadingWidget();
                  // return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ],
    );
  }
}
