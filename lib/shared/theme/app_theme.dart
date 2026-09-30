import 'package:flutter/material.dart';

// All colors in the app are generated from one seed color, so changing
// the look of the whole app only requires changing _seedColor.
class AppTheme {
  static const Color _seedColor = Colors.indigo;

  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _seedColor),
  );

  static ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    ),
  );
}
