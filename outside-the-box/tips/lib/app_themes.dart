import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    useMaterial3: true, // Modern görünüm için material 3 seti kullanılır
    scaffoldBackgroundColor: Colors.yellow, // Arka plan rengi
    primaryColor: Colors.deepOrange,

    // Yazı stilleri
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w100),
      bodyLarge: TextStyle(fontSize: 18, color: Colors.blue),
    ),

    // Appbar teması
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );
}
