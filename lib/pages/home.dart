import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing/pages/article.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> news = [];
  bool isLoading = true;
  String errorMessage = '';
  fetchNews() async {
    String url =
        "https://newsapi.org/v2/everything?q=tesla&from=2024-07-02&sortBy=publishedAt&apiKey=626e0e40c01c4427b5b7a628762b6efa";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> decodedJson = json.decode(response.body);
        setState(() {
          news = decodedJson['articles'];
          isLoading = false;
        });
      } else {
        log('Failed to Load Data');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'WH NEWS',
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  dynamic article = news[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Article(article: article),
                          ));
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      elevation: 4,
                      child: Column(children: [
                        CachedNetworkImage(
                            imageUrl: article['urlToImage'] ??
                                'https://static.vecteezy.com/system/resources/previews/010/586/271/non_2x/breaking-news-background-business-or-technology-template-breaking-news-text-on-dark-blue-with-light-effect-digital-technology-tv-news-show-broadcast-design-vector.jpg',
                            placeholder: (context, url) => const SizedBox(
                                height: 50, child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) {
                              log(url.toString());
                              log(error.toString());
                              return Image.network(
                                  'https://static.vecteezy.com/system/resources/thumbnails/013/704/508/original/world-map-background-news-studio-background-for-news-report-and-breaking-news-on-world-live-report-video.jpg');
                            }),
                        ListTile(
                          title: Text(
                            article['title'] ?? "No Title",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                    ),
                  );
                }));
  }
}
