import 'package:flutter/material.dart';

import 'navigation/navigation.dart';
import 'ui/common/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books',
      theme: UIConstants.materialTheme,
      routes: AppNavigation.getNavigationRoutes(),
    );
  }
}