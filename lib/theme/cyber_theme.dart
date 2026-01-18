import 'package:flutter/material.dart';

class CyberTheme {
  static const Color background = Color(0xFF050A14); // Deep dark
  static const Color primary = Color(0xFFD500F9); // Purple (Calories/Date)
  static const Color cyan = Color(0xFF00E5FF); // Protein
  static const Color yellow = Color(0xFFFFEA00); // Fat
  static const Color green = Color(0xFF00E676); // Carbs
  static const Color surface = Color(0xFF121212);
  
  // Aliases for backward compatibility
  static const Color secondary = cyan;
  static const Color accent = yellow;
  
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: cyan,
        surface: surface,
        background: background,
      ),
      fontFamily: 'Courier', 
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: secondary, fontFamily: 'Courier', fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: primary, fontFamily: 'Courier', fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: secondary, fontFamily: 'Courier'),
        bodyMedium: TextStyle(color: Colors.white, fontFamily: 'Courier'),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: secondary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Courier',
          shadows: [
            Shadow(color: secondary, blurRadius: 10),
          ]
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: secondary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: secondary.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: secondary, width: 2),
        ),
        labelStyle: const TextStyle(color: secondary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: const BeveledRectangleBorder(),
          textStyle: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold),
        ),
      ),
      iconTheme: const IconThemeData(
        color: secondary,
      ),
    );
  }
}
