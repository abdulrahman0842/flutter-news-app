import 'package:flutter/material.dart';
import 'package:testing/models/news_model.dart';
import 'package:testing/screens/article_page.dart';
import 'package:testing/screens/home.dart';

class VerticalNewsCard extends StatelessWidget {
  const VerticalNewsCard({
    super.key,
    required this.news,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;
  final NewsModel? news;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 1.5,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: news!.articles!.length,
          itemBuilder: (context, index) {
            Articles article = news!.articles![index];
            String publishedAtFormated =
                Home().parseDate(article.publishedAt ?? 'Null');
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
                      ),
                    ));
              },
              child: Card(
                color: Colors.transparent,
                margin: const EdgeInsets.all(4),
                elevation: 1,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    height: width * 0.3,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(article.urlToImage ??
                                'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg'))),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    height: MediaQuery.sizeOf(context).width * 0.3,
                    width: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title ?? 'UnAvailable',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(article.author ?? "Unknown",
                                  maxLines: 2,
                                  style: const TextStyle(color: Colors.blue)),
                            ),
                            Flexible(
                              child: Text(publishedAtFormated.substring(0, 10),
                                  style: const TextStyle(color: Colors.white)),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ]),
              ),
            );
          }),
    );
    // }
  }
}
// ListTile(
//                 leading:Image.network(article.urlToImage ??
//                   'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg'),

//                 title: Text(
//                   article.title ?? "No Title",
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
