import 'package:flutter/material.dart';

import 'colors.dart';

// ignore: avoid_classes_with_only_static_members
class UIConstants {

  static ThemeData materialTheme = ThemeData(
    primarySwatch: AppColors.createMaterialColor(AppColors.appbarBackground),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.scaffold_background,
    dividerTheme: const DividerThemeData(color: AppColors.gray3, thickness: 1),
  );
}
