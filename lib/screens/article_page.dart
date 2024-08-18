import 'package:flutter/material.dart';
import 'package:testing/models/news_model.dart';
import 'package:testing/provider/custom_theme.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage(
      {super.key,
      required this.article,
      required this.height,
      required this.width,
      required this.date,
      required this.index});
  final Articles article;
  final double height;
  final double width;
  final String date;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          Hero(
            tag: Key(article.urlToImage ?? 'DefaultImage $index'),
            child: Container(
              height: height * 0.4,
              width: width,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(article.urlToImage ??
                          'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg'))),
            ),
          ),
          Positioned(
            top: height * 0.38,
            child: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                  color: MyTheme.lightTheme.canvasColor,
                  borderRadius: BorderRadius.circular(20)),
              height: height * 0.9,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.02),
                  Text(article.author ?? 'Unknown'),
                  SizedBox(height: height * 0.01),
                  Text(
                    article.title ?? 'Not Available',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    date,
                    style: const TextStyle(fontWeight: FontWeight.w200),
                  ),
                  SizedBox(height: height * 0.005),
                  Text(
                    article.content ?? 'Null',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ))));
  }
}
