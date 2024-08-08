import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:testing/models/news_model.dart';
import 'package:testing/screens/article.dart';
import 'package:testing/services/api_service.dart';
import 'package:testing/widgets/horizontal_news_header.dart';

import '../widgets/vertical_news_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];

  NewsModel? news;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      NewsModel fetchedNews = await APIService().fetchData();
      setState(() {
        news = fetchedNews;
        isLoading = false;
      });
      log(news!.totalResults.toString());
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        backgroundColor: const Color.fromARGB(122, 211, 211, 225),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                  child: Text(
                    'Top Headlines',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : HorizontalNewsHeader(
                        height: height, width: width, news: news!),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: height * 2,
                        child: VerticalNewsCard(news: news!))
              ],
            ),
          ),
        )));
  }
}
