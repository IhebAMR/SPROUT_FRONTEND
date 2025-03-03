import 'package:flutter/material.dart';

class AppTheme {
  // Color palette
  static const Color primaryDark = Color(0xFF4B5943);    // Deep olive green
  static const Color primary = Color(0xFF8FB43A);        // Vibrant green
  static const Color primaryLight = Color(0xFFB7CE66);   // Light green
  static const Color accent = Color(0xFFC8D6A2);         // Pale green
  static const Color background = Color(0xFFDCDFDA);     // Light gray

  // Create the theme
  static ThemeData get lightTheme {
    return ThemeData(
      // Primary color scheme
      primaryColor: primary,
      primaryColorDark: primaryDark,
      primaryColorLight: primaryLight,
      colorScheme: ColorScheme.light(
        primary: primary, 
        secondary: primaryLight,
        background: background,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: primaryDark,
        onBackground: primaryDark,
        onSurface: primaryDark,
      ),
      
      // Background color
      scaffoldBackgroundColor: background,
      
      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: primaryDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      
      // Card theme
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryDark,
        ),
      ),
      
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: accent, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        labelStyle: TextStyle(color: primaryDark),
      ),
      
      // Text themes
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: primaryDark,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: primaryDark,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: primaryDark,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: primaryDark,
        ),
        bodyMedium: TextStyle(
          color: primaryDark,
        ),
      ),
      
      // Dialog theme
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}