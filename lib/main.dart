import 'package:flutter/material.dart';
import 'package:newsvibe/models/news_model.dart';
import 'package:newsvibe/provider/custom_theme.dart';
import 'package:newsvibe/provider/news_provider.dart';
import 'package:newsvibe/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ArticlesAdapter());
  Hive.registerAdapter(SourceAdapter());
  await Hive.openBox<Articles>('NewsArticles');
  runApp(ChangeNotifierProvider(
      create: (context) => NewsProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NewsVibe',
      theme: MyTheme.lightTheme,
      home: const Home(),
    );
  }
}
