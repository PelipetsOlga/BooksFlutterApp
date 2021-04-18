import 'dart:developer';

import 'package:books_app/data/api/api.dart';
import 'package:flutter/material.dart';

import 'data/repo/repository.dart';
import 'navigation/navigation.dart';
import 'ui/common/constants.dart';
import 'package:dio/dio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    dio.options.headers = BooksApi.headers;
    final api = BooksApi(dio);

    final repository = BooksRepositoryImpl(api);

    repository.getAllBooks().then((it) {
      log(it.toString());
    });

    return MaterialApp(
      title: 'Books',
      theme: UIConstants.materialTheme,
      routes: AppNavigation.getNavigationRoutes(),
    );
  }
}