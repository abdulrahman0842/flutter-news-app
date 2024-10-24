import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsvibe/models/news_model.dart';
import 'package:newsvibe/provider/article_localization.dart';
import 'package:newsvibe/provider/custom_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
            tag: Key('${article.urlToImage} $index'),
            child:
                // Container(
                //   height: height * 0.4,
                //   width: width,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //           fit: BoxFit.cover,
                //           image: NetworkImage(article.urlToImage ??
                //               'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg'))),
                // )
                CachedNetworkImage(
              imageUrl: article.urlToImage ??
                  'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg',
              imageBuilder: (context, imageProvider) => Container(
                height: height * 0.4,
                width: width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)),
              ),
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned(
              top: 10,
              left: 10,
              child: IconButton.outlined(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.black54)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ))),
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
          ),
          Positioned(
              top: height * 0.38,
              right: 10,
              child: ValueListenableBuilder(
                valueListenable:
                    Hive.box<Articles>('NewsArticles').listenable(),
                builder: (context, Box<Articles> box, child) {
                  return IconButton(
                      onPressed: () {
                        ArticleLocalization().toggleArticleHive(article);
                      },
                      icon: box.containsKey(article.title!.substring(0, 10))
                          ? const Icon(
                              Icons.bookmark,
                              size: 32,
                            )
                          : const Icon(
                              Icons.bookmark_border_outlined,
                              size: 32,
                            ));
                },
              )),
        ],
      ),
    ))));
  }
}
