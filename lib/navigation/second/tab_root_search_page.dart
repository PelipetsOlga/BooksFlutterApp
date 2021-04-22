import 'package:flutter/material.dart';

import '../tab_item.dart';
import 'router_search.dart';

class TabRootSearchPage extends StatelessWidget {
  
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  TabRootSearchPage({required this.navigatorKey,required this.tabItem});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: RouterSearch.search_initialRoute,
      onGenerateRoute: RouterSearch.generateRoute,
    );
  }
}
