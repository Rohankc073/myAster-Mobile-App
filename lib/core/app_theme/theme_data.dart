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
            fontSize: 20, color: Colors.black, fontFamily: 'Rockwell')),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
            fontSize: 18, color: Colors.white10, fontFamily: "Rockwell"),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
