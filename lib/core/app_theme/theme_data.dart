import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.grey[100],
    fontFamily: 'Rockwell',
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Color(0xFF3579FF),
      elevation: 4,
      shadowColor: Colors.amber,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontFamily: 'Rockwell',
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.white10,
          fontFamily: "Rockwell",
        ),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white, // Background color of the navigation bar
      selectedItemColor:
          Color(0xFF3579FF), // Color of the selected icon and label
      unselectedItemColor:
          Colors.grey, // Color of the unselected icon and label
      selectedLabelStyle: TextStyle(
        fontFamily: 'Rockwell', // Font for selected labels
        fontSize: 14, // Size for selected labels
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Rockwell', // Font for unselected labels
        fontSize: 12, // Size for unselected labels
      ),
    ),
  );
}
