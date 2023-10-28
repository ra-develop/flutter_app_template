import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'material_color_generator.dart';

class AppTheme {
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  final lightDefaultBase = ThemeData.light();
  final darkDefaultBase = ThemeData.dark();

  ThemeData get lightBase => ThemeData(
        visualDensity: visualDensity,
        // backgroundColor: AppColors.background,
        colorScheme: ColorScheme.light(primary: AppColors.primary),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        primarySwatch: AppColors.colorPalette,
        appBarTheme: _appBarTheme,
      );

  ThemeData get darkBase => ThemeData(
        // brightness: Brightness.dark,
        visualDensity: visualDensity,
        colorScheme: ColorScheme.dark(primary: AppColors.primary),
        // backgroundColor: _DarkColors.background,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        primarySwatch: AppColors.colorPalette,
        appBarTheme: _appBarTheme,
      );

  // TODO Implementing the dark/light appbarTheme
  AppBarTheme get _appBarTheme => AppBarTheme(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.primary,
        ),
      );
}
