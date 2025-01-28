import 'package:flutter/material.dart';
import 'package:myasteer/app/constants/theme_constant.dart'; // Replace with your constants file path

class AppTheme {
  AppTheme._();

  static ThemeData getApplicationTheme({required bool isDarkMode}) {
    return ThemeData(
      // Color Scheme for light or dark mode
      colorScheme: isDarkMode
          ? const ColorScheme.dark(
              primary: ThemeConstant.darkPrimaryColor,
            )
          : const ColorScheme.light(
              primary: Color(0xFF3579FF), // Replace with your primary color
            ),

      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      fontFamily: 'Rockwell', // Replace with your preferred font
      useMaterial3: true,

      // AppBar theme customization
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: ThemeConstant.appBarColor,
        elevation: 4,
        shadowColor: Colors.amber,
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontFamily: 'Rockwell',
        ),
      ),

      // Elevated button theme customization
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontFamily: "Rockwell",
          ),
          backgroundColor: ThemeConstant.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      // Input field theme customization
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(),
        labelStyle: TextStyle(
          fontSize: 20,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeConstant.primaryColor,
          ),
        ),
      ),

      // Progress bar theme customization
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ThemeConstant.primaryColor,
      ),

      // Bottom navigation bar theme customization
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.blue, // Background color
        selectedItemColor: Colors.white, // Selected item color
        unselectedItemColor: Colors.black, // Unselected item color
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
