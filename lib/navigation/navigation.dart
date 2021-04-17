import 'package:books_app/ui/home/home_widget.dart';
import 'package:flutter/material.dart';

class AppNavigation {
  static const HOME = '/';

  static Map<String, WidgetBuilder> getNavigationRoutes() {
    return <String, WidgetBuilder>{
      AppNavigation.HOME: (_) => HomeScreen(),
    };
  }
}

