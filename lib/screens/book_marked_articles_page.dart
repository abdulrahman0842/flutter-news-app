import 'package:flutter/material.dart';
import 'package:testing/models/news_model.dart';
import 'package:testing/provider/article_localization.dart';
import 'package:testing/widgets/horizontal_news_header.dart';

class BookMarkedArticlesPage extends StatefulWidget {
  const BookMarkedArticlesPage({super.key});

  @override
  State<BookMarkedArticlesPage> createState() => _BookMarkedArticlesPageState();
}

class _BookMarkedArticlesPageState extends State<BookMarkedArticlesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                ArticleLocalization().clearBox();
              });
            },
            icon: const Icon(Icons.clear_all_sharp),
          )
        ],
      ),
      body: FutureBuilder(
          future: ArticleLocalization().fetchFromHive(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error Occured');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.data!.isEmpty) {
              return const Text('No data');
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Articles article = snapshot.data![index];
                  return ListTile(
                    title: Text(article.title ?? 'null'),
                  );
                });
          }),
    );
  }
}
