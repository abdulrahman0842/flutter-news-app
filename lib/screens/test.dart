import 'package:flutter/material.dart';
import 'package:testing/screens/category_page.dart';
import 'package:testing/screens/home.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    int currentIndex = 0;
    PageController pageController = PageController();
    void onTapped(int index) {
      setState(() {
        currentIndex = index;
      });
      pageController.jumpToPage(index);
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 134, 241, 200),
      body: PageView(
        controller: pageController,
        children: [const Home(), const CategoryPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTapped,
          currentIndex: currentIndex,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Category')
          ]),
    );
  }
}
