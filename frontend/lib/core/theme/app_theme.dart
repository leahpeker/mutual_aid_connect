import 'package:flutter/material.dart';

class AppTheme {
  static const Color accentGray = Color(0xFFCCCCCC);
  static const Color buttonRed = Color(0xFFE53935);
  
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primarySwatch: Colors.red,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: buttonRed,
      secondary: accentGray,
      background: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonRed,
        foregroundColor: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.grey[900],
      elevation: 0,
    ),
  );
} 