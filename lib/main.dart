import 'dart:developer';

import 'package:flutter/material.dart';

import 'domain/repository/repository.dart';
import 'injection.dart';
import 'navigation/navigation.dart';
import 'ui/common/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repository = getIt.get<BooksRepository>();

    repository.getAllBooks().then((it) {
      log(it.toString());
      it.items.forEach((element) {
        log(element.toString());
      });
    });

    return MaterialApp(
      title: 'Books',
      theme: UIConstants.materialTheme,
      routes: AppNavigation.getNavigationRoutes(),
    );
  }
}
