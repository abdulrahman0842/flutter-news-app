import 'package:flutter/material.dart';
import 'package:testing/view_model/news_view_model.dart';
import 'package:testing/widgets/horizontal_news_header.dart';
import 'package:testing/widgets/vertical_news_card.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
  parseDate(String publishedAt) {
    if (publishedAt == 'Null') {
      return 'Not Available';
    } else {
      return DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(publishedAt));
    }
  }
}

enum FilterList { aljazeera, bbcnews, ndtv, reuters, arynews }

class _HomeState extends State<Home> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedSource;
  String name = 'bbc-news';
  ///// unwanted

  List categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        backgroundColor: const Color.fromARGB(111, 111, 111, 158),
        appBar: _buildAppBar(),
        body: _buildUI(height, width));
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('WiH News',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26)),
      actions: [
        PopupMenuButton<FilterList>(
            icon: const Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
            initialValue: selectedSource,
            popUpAnimationStyle: AnimationStyle(curve: Curves.easeInOut),
            onSelected: (item) {
              name = item.name;
              if (FilterList.aljazeera.name == item.name) {
                name = 'al-jazeera-english';
              }
              if (FilterList.bbcnews.name == item.name) {
                name = 'bbc-news';
              }
              if (FilterList.ndtv.name == item.name) {
                name = 'ndtv';
              }
              if (FilterList.reuters == item.name) {
                name = 'reuters';
              }
              if (FilterList.arynews.name == item.name) {
                name = 'ary-news';
              }
              setState(() {});
            },
            itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                  const PopupMenuItem(
                    value: FilterList.aljazeera,
                    child: Text('Al Jazeera'),
                  ),
                  const PopupMenuItem(
                    value: FilterList.bbcnews,
                    child: Text('BBC News'),
                  ),
                  const PopupMenuItem<FilterList>(
                    value: FilterList.reuters,
                    child: Text('Reuters'),
                  ),
                  const PopupMenuItem(
                    value: FilterList.ndtv,
                    child: Text('NDTV'),
                  ),
                  const PopupMenuItem(
                    value: FilterList.arynews,
                    child: Text('ARY news'),
                  )
                ])
      ],
      backgroundColor: Colors.transparent,
    );
  }

  SafeArea _buildUI(double height, double width) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          const SizedBox(
            child: Text(
              'Top Headlines',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: height * 0.5,
            width: width * 0.99,
            child: FutureBuilder(
                future: newsViewModel.fetchNewsChannelHeadline(name),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.data!.articles!.isEmpty) {
                    return const Center(
                      child: Text(
                        'Currently not available.\nChange the Publisher',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    return HorizontalNewsHeader(
                        height: height, width: width, news: snapshot.data!);
                  }
                }),
          ),
          FutureBuilder(
              future: newsViewModel.fetchCountryHeadline(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return VerticalNewsCard(
                    height: height,
                    width: width,
                    news: snapshot.data,
                  );
                }
              })
        ],
      ),
    ));
  }
}
