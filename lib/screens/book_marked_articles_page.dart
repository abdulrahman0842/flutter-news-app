import 'package:flutter/material.dart';
import 'package:testing/models/news_model.dart';
import 'package:testing/provider/article_localization.dart';
import 'package:testing/screens/article_page.dart';
import 'package:testing/screens/home.dart';

class BookMarkedArticlesPage extends StatefulWidget {
  const BookMarkedArticlesPage({super.key});

  @override
  State<BookMarkedArticlesPage> createState() => _BookMarkedArticlesPageState();
}

class _BookMarkedArticlesPageState extends State<BookMarkedArticlesPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
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
                padding: const EdgeInsets.all(8),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Articles article = snapshot.data![index];
                  String publishedAtFormated =
                      const Home().parseDate(article.publishedAt ?? 'Null');
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticlePage(
                                article: article,
                                height: height,
                                width: width,
                                date: publishedAtFormated,
                                index: index,
                              ),
                            ));
                      },
                      child: Card(
                        elevation: 12,
                        margin: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Stack(children: [
                          Hero(
                              tag: Key('${article.urlToImage} $index'),
                              child: Container(
                                height: height * 0.22,
                                width: width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(article
                                                .urlToImage ??
                                            'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg'))),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black54),
                                ),
                              )),
                          SizedBox(
                            height: height * 0.22,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    article.title ?? 'UnAvailable',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(article.author ?? "Unknown",
                                            maxLines: 2,
                                            style: const TextStyle(
                                                color: Colors.blue)),
                                      ),
                                      Flexible(
                                        child: Text(
                                          publishedAtFormated.substring(0, 10),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ));
                });
          }),
    );
  }
}
