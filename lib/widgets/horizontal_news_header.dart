import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsvibe/models/news_model.dart';
import 'package:newsvibe/provider/article_localization.dart';
import 'package:newsvibe/screens/article_page.dart';
import 'package:newsvibe/screens/home.dart';

class HorizontalNewsHeader extends StatelessWidget {
  const HorizontalNewsHeader(
      {super.key,
      required this.height,
      required this.width,
      required this.news});

  final double height;
  final double width;
  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: news.articles!.length,
      itemBuilder: (context, index) {
        Articles article = news.articles![index];
        String publishedAtFormated =
            const Home().parseDate(article.publishedAt ?? 'Null');
        return InkWell(
            onLongPress: () {
              ArticleLocalization().toggleArticleHive(article);
            },
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
              margin: const EdgeInsets.only(left: 12, right: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Hero(
                tag: Key('${article.urlToImage} $index'),
                child: Container(
                  height: height * 0.55,
                  width: width * 0.75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: article.urlToImage ??
                            'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Positioned(
                        bottom: height * 0.7 / 20,
                        left: width * 0.7 / 15,
                        right: width * 0.7 / 15,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          height: 200,
                          width: width * 0.7 / 1.2,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(122, 23, 37, 49),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Material(
                                type: MaterialType.transparency,
                                child: Text(
                                  article.title ?? 'Unavailable',
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: Text(
                                        article.author ?? 'Unknown',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Material(
                                    type: MaterialType.transparency,
                                    child: Text(
                                      publishedAtFormated,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
