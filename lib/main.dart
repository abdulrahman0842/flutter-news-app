import 'package:flutter/material.dart';
import 'package:testing/screens/temp.dart';
import 'package:testing/screens/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API Calls',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(43, 211, 211, 225)),
        useMaterial3: true,
      ),
      home: const Test(),
    );
  }
}
