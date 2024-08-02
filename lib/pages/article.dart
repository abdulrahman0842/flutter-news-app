import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Article extends StatelessWidget {
  const Article({super.key, required this.article});
  final dynamic article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(children: [
        CachedNetworkImage(
          imageUrl: article['urlToImage'],
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                article['title'] ?? 'Title is not Available',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                article['author'] ?? 'Unknown author',
                style:
                    const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 4),
              Text(article['publishedAt']),
              const SizedBox(height: 16),
              Text(
                article['content'] ?? 'Unknown author',
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
