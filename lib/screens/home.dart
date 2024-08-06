import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:testing/models/news_model.dart';
import 'package:testing/screens/article.dart';
import 'package:testing/services/api_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    // double sheight = MediaQuery.sizeOf(context).height;
    // double swidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'WH NEWS',
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : verticalListNews());
  }

  Widget verticalListNews() {
    return ListView.builder(
        itemCount: news!.totalResults,
        itemBuilder: (context, index) {
          Articles article = news!.articles![index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Article(article: article),
                  ));
            },
            child: Card(
              margin: const EdgeInsets.all(8),
              elevation: 4,
              child: Column(children: [
                Image.network(article.urlToImage ??
                    'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg'),
                ListTile(
                  title: Text(
                    article.title ?? "No Title",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ),
          );
        });
    // }
  }
}
