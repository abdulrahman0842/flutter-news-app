import 'package:flutter/material.dart';
import 'package:testing/models/news_model.dart';
import 'package:testing/provider/custom_theme.dart';
import 'package:testing/provider/news_provider.dart';
import 'package:testing/view_model/news_view_model.dart';
import 'package:testing/widgets/categories_banner.dart';
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

  final List categories = [
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];
  @override
  void initState() {
    super.initState();
    getChannelHeadline();
  }

  Future<NewsModel> getChannelHeadline() async {
    return await Provider.of<NewsProvider>(context, listen: false)
        .fetchNewsChanelHeadline(name);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(child: _buildUI(height, width)),
   
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: MyTheme.lightTheme.primaryColor,
      centerTitle: true,
      title: const Text('Daily News',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26)),
      actions: [filterChannelPopUpMenu()],
    );
  }

  PopupMenuButton<FilterList> filterChannelPopUpMenu() {
    return PopupMenuButton<FilterList>(
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
          getChannelHeadline();
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
            ]);
  }

  SafeArea _buildUI(double height, double width) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            CategoriesBanner(
              height: height,
              width: width,
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Top Headlines',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
                height: height * 0.5,
                width: width * 0.99,
                child: Consumer<NewsProvider>(
                    builder: ((context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final newsModel = provider.newsModel;
                  if (newsModel == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return HorizontalNewsHeader(
                        height: height, width: width, news: newsModel);
                  }
                }))),
            // FutureBuilder(
            //     future:
            //         Provider.of<NewsProvider>(context).fetchCountryHeadline(),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const Center(child: CircularProgressIndicator());
            //       } else if (snapshot.hasError) {
            //         return Center(child: Text(snapshot.error.toString()));
            //       } else {
            //         return VerticalNewsCard(
            //             news: snapshot.data, height: height, width: width);
            //       }
            //     })
          ],
        ),
      ),
    ));
  }
}
