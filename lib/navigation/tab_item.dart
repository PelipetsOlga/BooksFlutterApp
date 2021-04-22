import 'package:flutter/material.dart';

enum TabItem { home, search }

const Map<TabItem, String> tabName = {
  TabItem.home: 'Home',
  TabItem.search: 'Search',
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.home: Colors.blue,
  TabItem.search: Colors.orange,
};

