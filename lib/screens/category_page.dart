import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:testing/provider/custom_theme.dart';
import 'package:testing/provider/news_provider.dart';
import 'package:testing/widgets/vertical_news_card.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.category});
  final String category;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: MyTheme.lightTheme.primaryColor,
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: _buildUI(height, width));
  }

  Column _buildUI(double height, double width) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          child: FutureBuilder(
              future: NewsProvider().fetchCategoryNews(widget.category),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  return const Text(
                      textAlign: TextAlign.center, 'Error has ocurred!');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        return VerticalNewsCard(
                            news: snapshot.data, height: height, width: width);
                      });
                }
              }))
    ]);
  }
}
