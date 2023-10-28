import 'dart:math';

import 'package:flutter/material.dart';

abstract class AppColors {
  // TODO selecting color depended from system theme and possibilities choice in the app settings
  static const backgroundLight = _LightColors.background;
  static const backgroundDark = _DarkColors.background;

  /// Set colors palette
  static final primary = _Palette.primary;
  static final colorPalette = _Palette.colorPalette;
}

abstract class _LightColors {
  static const background = Colors.white;
}

abstract class _DarkColors {
  static const background = Colors.black;
}

abstract class _Palette {
  static final MaterialColor colorPalette = _generateMaterialColor(primary);

  /// To set primary color in value (Hex)
  static final int _mcgPalettePrimaryValue = Colors.blue.value; //0xFFF31753;

  static final Color primary = Color(_mcgPalettePrimaryValue);

  static int _tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color _tintColor(Color color, double factor) => Color.fromRGBO(
      _tintValue(color.red, factor),
      _tintValue(color.green, factor),
      _tintValue(color.blue, factor),
      1);

  static MaterialColor _generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: _tintColor(color, 0.5),
      100: _tintColor(color, 0.4),
      200: _tintColor(color, 0.3),
      300: _tintColor(color, 0.2),
      400: _tintColor(color, 0.1),
      500: _tintColor(color, 0),
      600: _tintColor(color, -0.1),
      700: _tintColor(color, -0.2),
      800: _tintColor(color, -0.3),
      900: _tintColor(color, -0.4),
    });
  }
}
