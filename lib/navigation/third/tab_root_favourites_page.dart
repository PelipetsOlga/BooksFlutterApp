import 'package:books_app/navigation/third/router_favourites.dart';
import 'package:flutter/material.dart';

import '../tab_item.dart';

class TabRootFavouritesPage extends StatelessWidget {
  
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  TabRootFavouritesPage({required this.navigatorKey,required this.tabItem});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: RouterFavourites.favour_initialRoute,
      onGenerateRoute: RouterFavourites.generateRoute,
    );
  }
}
