import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testing/models/news_model.dart';

class VerticalNewsCard extends StatelessWidget {
  const VerticalNewsCard({
    super.key,
    required this.news,
  });

  final NewsModel? news;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: news!.articles!.length,
        itemBuilder: (context, index) {
          Articles article = news!.articles![index];
          return Card(
            color: Colors.transparent,
            margin: const EdgeInsets.all(8),
            elevation: 1,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: const EdgeInsets.all(8),
                height: MediaQuery.sizeOf(context).width * 0.3,
                width: MediaQuery.sizeOf(context).width * 0.3,
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
                          child: Text(article.source!.name ?? 'UnAvaible',
                              style: const TextStyle(color: Colors.white)),
                        )
                      ],
                    )
                  ],
                ),
              )
            ]),
          );
        });
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
