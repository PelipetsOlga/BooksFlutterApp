import 'package:flutter/material.dart';

import 'tab_item.dart';

class BottomNavigation extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  BottomNavigation({required this.currentTab, required this.onSelectTab});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentTab.index,
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.home, context),
        _buildItem(TabItem.search, context),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem, BuildContext context) {
    return BottomNavigationBarItem(
      icon: tabItem == TabItem.home
          ? Icon(Icons.home)
          : Icon(Icons.search),
      label: tabName[tabItem],
    );
  }
}
