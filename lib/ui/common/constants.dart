import 'package:flutter/material.dart';

import 'colors.dart';

// ignore: avoid_classes_with_only_static_members
class UIConstants {

  static ThemeData materialTheme = ThemeData(
    primarySwatch: AppColors.createMaterialColor(AppColors.appbarBackground),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.scaffold_background,
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: AppColors.appbarBackground,
      textTheme: ThemeData.dark().textTheme.copyWith(
            title: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.gray3, thickness: 1),
  );
}
