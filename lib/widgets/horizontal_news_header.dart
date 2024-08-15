import 'package:flutter/material.dart';
import 'package:testing/models/news_model.dart';
import 'package:testing/screens/article_page.dart';
import 'package:testing/screens/home.dart';

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
        String publishedAtFormated = const Home().parseDate(article.publishedAt??'Null');
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticlePage(article:article, height: height, width: width, date: publishedAtFormated,),
                ));
          },
          child: Card(
            child: Container(
              height: height * 0.55,
              width: width * 0.75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(article.urlToImage ??
                          'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg'))),
              child: Stack(children: [
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
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            article.title ?? 'Unavailable',
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(article.source!.name ?? 'Unknown',
                                  style: const TextStyle(color: Colors.white)),
                              Text(publishedAtFormated,
                                  style: const TextStyle(color: Colors.white))
                            ],
                          )
                        ],
                      ),
                    )),
              ]),
            ),
          ),
        );
      },
    );
  }
}