import 'dart:developer';

import 'package:books_app/domain/repository/repository.dart';
import 'package:books_app/tools/logger.dart';
import 'package:flutter/material.dart';

import '../../injection.dart';

class HomeScreen extends StatelessWidget {
  late Log logger;
  final logTag = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    final repository = getIt.get<BooksRepository>();
    final logger = getIt.get<Log>();

    repository.getAllBooks().then((it) {
      logger.log(logTag, it.toString());
      it.items.forEach((element) {
        logger.log(logTag, element.toString());
      });
    });

    return Scaffold(
      appBar: AppBar(title: Text("Books")),
      body: Center(
        child: Text("Home content"),
      ),
    );
  }
}
