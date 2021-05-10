import 'package:books_app/ui/book/book_page.dart';
import 'package:books_app/ui/favourites/favourites_widget.dart';
import 'package:flutter/material.dart';

class RouterFavourites {
  static const String favour_initialRoute = '/';
  static const String favour_book = '/book';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case favour_initialRoute:
        return MaterialPageRoute(builder: (_) => FavouritesScreen());
      case favour_book:
        if (args is BookPageArgs) {
          return MaterialPageRoute(builder: (_) => BookPage(args));
        } else {
          return _errorRoute();
        }
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text('Error of Favourites screen')),
          body: Center(child: Text('Error of Favourites screen')));
    });
  }
}
