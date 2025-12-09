import 'package:flutter/material.dart';

/// 다크 미니멀 톤의 전역 테마
class AppTheme {
  static ThemeData get dark {
    const primary = Colors.white;
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: Colors.pinkAccent,
        background: Colors.black,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white, fontSize: 14),
        titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
