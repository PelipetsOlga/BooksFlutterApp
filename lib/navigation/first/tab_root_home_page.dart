import 'package:flutter/material.dart';

import '../tab_item.dart';
import 'router_home.dart';

class TabRootHomePage extends StatelessWidget {
  
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  TabRootHomePage({required this.navigatorKey,required this.tabItem});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: RouterHome.home_initialRoute,
      onGenerateRoute: RouterHome.generateRoute,
    );
  }
}
