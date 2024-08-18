import 'package:flutter/material.dart';
import 'package:testing/provider/custom_theme.dart';
import 'package:testing/provider/news_provider.dart';
import 'package:testing/widgets/vertical_news_card.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectedIndex = 0;
  final List categories = [
    'General',
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        backgroundColor: MyTheme.lightTheme.canvasColor,
        appBar: AppBar(
          backgroundColor: MyTheme.lightTheme.primaryColor,
          title: Text('Read by Category'),
        ),
        body: _buildUI(height, width));
  }

  Column _buildUI(double height, double width) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: List<Widget>.generate(
                  categories.length,
                  (index) => Padding(
                        padding: const EdgeInsets.only(left: 6.0, right: 6),
                        child: newsCategoryChip(index),
                      ))),
        ),
      ),
      const Divider(
        thickness: 2,
      ),
      Expanded(
          child: FutureBuilder(
              future:
                  NewsProvider().fetchCategoryNews(categories[_selectedIndex]),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        return VerticalNewsCard(
                            news: snapshot.data, height: height, width: width);
                      });
                }
              }))
    ]);
  }

  ChoiceChip newsCategoryChip(int index) {
    return ChoiceChip(
      label: Text(categories[index]),
      selected: _selectedIndex == index,
      onSelected: (bool selected) {
        setState(() {
          _selectedIndex = selected ? index : 0;
        });
      },
    );
  }
}
