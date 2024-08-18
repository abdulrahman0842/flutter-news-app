import 'package:flutter/material.dart';
import 'package:testing/provider/custom_theme.dart';
import 'package:testing/provider/news_provider.dart';
import 'package:testing/screens/category_page.dart';
import 'package:testing/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:testing/screens/test.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => NewsProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API Calls',
      theme: MyTheme.lightTheme,
      home: const Test(),
    );
  }
}
