import 'package:books_app/ui/home/home_widget.dart';
import 'package:flutter/material.dart';

class RouterHome {
  static const String home_initialRoute = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case home_initialRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text('Error of Home screen')),
          body: Center(child: Text('Error of Home screen')));
    });
  }
}
