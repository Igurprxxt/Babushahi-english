// This file stores the global state of news categories
// This is created due to change in the client requirement for the tab very frequently.
// So creating a global list of tabs and then using it in the tab bar and tab bar view and the choose interest page

import 'package:babushahienglish/screens/home.dart';
import 'package:flutter/material.dart';

final Map<String, String> _newsChoices = <String, String>{
  // The keys are to be shown in the Ui, the values to used for api calls
  // TODO: Check if all the API are working
  'Current News': 'currentnews',
  'Blog Opinions': 'blogs',
  // 'Regional Briefs': '',
  'Infotainment/Lifestyle': 'entertainment',
  'Technology and Trends': 'trends',
  'Business': 'business',
  'Education/Career': 'education',
  'Transfers/Postings': 'transfers',
  'Sports and Fitness': 'sports',
  'World/ Tourism and Travel': 'worldnews',
  'Do You Know': 'doyouknow',
  'Babushahi Data bank': 'databank',
  'Personality/Interview': 'personality',
  'Books/Literature': 'books',
  'Video Gallery': 'videogallery',
  'Regional News': 'regionalnews',
  // 'Health and Fitness': '',
};

Map<String, String> get newsChoices => _newsChoices;

List<Tab> tabBarHeaders() {
  // This returns the list of Tabs for the tab bar
  List<Tab> _tabBarViewTabs = [
    // First TabView is the home tab that shows user interest news
    const Tab(text: 'Home'),
  ];
  _newsChoices.forEach((key, value) {
    _tabBarViewTabs.add(Tab(
      text: key,
    ));
  });

  return _tabBarViewTabs;
}

List<Widget> tabBarViews({String? searchKeyword}) {
  // print('Search keyword: $searchKeyword');
  // This returns the list of Tabs for the tab bar
  List<Widget> tabBarViewTabs = [];
  if (searchKeyword != null) {
    // Adding search Keyword to the list of tabs if search keyword exists
    tabBarViewTabs.add(SearchTab(searchKeyword));
  } else {
    tabBarViewTabs.add(const HomeTab());
  }
  _newsChoices.forEach((key, value) {
    tabBarViewTabs.add(
      CategoryHomeTab(newsCategory: value),
    );
  });

  return tabBarViewTabs;
}
