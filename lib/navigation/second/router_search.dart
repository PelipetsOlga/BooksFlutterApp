import 'package:books_app/ui/home/home_widget.dart';
import 'package:books_app/ui/search/search_widget.dart';
import 'package:flutter/material.dart';

class RouterSearch {

  static const String search_initialRoute = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case search_initialRoute:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text('Error of Search screen')),
          body: Center(child: Text('Error of Search screen')));
    });
  }
}
