import 'package:flutter/material.dart';
import 'package:testing/provider/custom_theme.dart';
import 'package:testing/provider/news_provider.dart';
import 'package:testing/screens/category_page.dart';
import 'package:testing/view_model/news_view_model.dart';
import 'package:testing/widgets/horizontal_news_header.dart';
import 'package:testing/widgets/vertical_news_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        backgroundColor: MyTheme.lightTheme.canvasColor,
        appBar: _buildAppBar(),
        body: _buildUI(height, width));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: MyTheme.lightTheme.primaryColor,
      centerTitle: true,
      title: const Text('WiH News',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26)),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CategoryPage()));
            },
            icon: const Icon(
              Icons.category_outlined,
              color: Colors.white,
            )),
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

              Provider.of<NewsProvider>(context, listen: false)
                  .fetchNewsChanelHeadline(name);
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
              child:
                  Consumer<NewsProvider>(builder: (context, provider, child) {
                final newsModel = provider.newsModel;
                provider.fetchNewsChanelHeadline(name);
                return newsModel == null
                    ? const Center(child: CircularProgressIndicator())
                    : HorizontalNewsHeader(
                        height: height, width: width, news: newsModel);
              })),
          FutureBuilder(
              future: NewsProvider().fetchCountryHeadline(),
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
