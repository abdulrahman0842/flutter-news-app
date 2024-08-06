import 'package:flutter/material.dart';
import 'package:testing/models/news_model.dart';

class Article extends StatelessWidget {
  const Article({super.key, required this.article});
  final Articles article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(children: [
        Image.network(article.urlToImage ?? 'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg'),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                article.title ?? 'Title is not Available',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                article.author ?? 'Unknown author',
                style:
                    const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 4),
              Text(article.publishedAt!),
              const SizedBox(height: 16),
              Text(
                article.content ?? 'Unknown author',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ]),
    )));
  }
}
