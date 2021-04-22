
import 'package:flutter/material.dart';

import 'injection.dart';
import 'navigation/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(BooksApp());
}
