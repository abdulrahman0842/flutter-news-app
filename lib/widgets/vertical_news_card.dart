import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsvibe/models/news_model.dart';
import 'package:newsvibe/screens/home.dart';
import 'package:newsvibe/screens/article_page.dart';

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
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: news!.articles!.length,
        itemBuilder: (context, index) {
          Articles article = news!.articles![index];
          String publishedAtFormated =
              const Home().parseDate(article.publishedAt ?? 'Null');
          log(news!.articles!.length.toString());
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
                child: Stack(
                  children: [
                    Hero(
                      tag: Key('${article.urlToImage} $index'),
                      child: Container(
                        height: height * 0.20,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: article.urlToImage ??
                                  'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              article.title ?? 'Unavailable',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    article.author ?? "Unknown",
                                    maxLines: 2,
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    publishedAtFormated.substring(0, 10),
                                    style: const TextStyle(color: Colors.white),
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
              ));
        });
    // }
  }
}

// class OldNewsCard extends StatelessWidget {
//   const OldNewsCard({
//     super.key,
//     required this.article,
//     required this.publishedAtFormated,
//     required this.width,
//     required this.index,
//   });

//   final Articles article;
//   final String publishedAtFormated;
//   final double width;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//       Container(
//         padding: const EdgeInsets.all(4),
//         height: MediaQuery.sizeOf(context).width * 0.3,
//         width: 180,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               article.title ?? 'UnAvailable',
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Flexible(
//                   child: Text(article.author ?? "Unknown",
//                       maxLines: 2, style: const TextStyle(color: Colors.blue)),
//                 ),
//                 Flexible(
//                   child: Text(
//                     publishedAtFormated.substring(0, 10),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//       Hero(
//         tag: Key('${article.urlToImage} $index'),
//         child: Container(
//           margin: const EdgeInsets.all(8),
//           height: width * 0.35,
//           width: width * 0.35,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: NetworkImage(article.urlToImage ??
//                       'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg'))),
//         ),
//       ),
//     ]);
//   }
// }
// ListTile(
//                 leading:Image.network(article.urlToImage ??
//                   'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg'),

//                 title: Text(
//                   article.title ?? "No Title",
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
