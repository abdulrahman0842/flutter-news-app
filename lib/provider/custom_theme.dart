import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 133, 185, 165)),
      );
}
