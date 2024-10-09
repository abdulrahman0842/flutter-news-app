import 'package:flutter/material.dart';
import 'package:testing/screens/category_page.dart';

class CategoriesBanner extends StatelessWidget {
  CategoriesBanner({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;
  final List category = [
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];
  final List<String> img = [
    'https://online.hbs.edu/Style%20Library/api/resize.aspx?imgpath=/PublishingImages/overhead-view-of-business-strategy-meeting.jpg&w=1200&h=630',
    'https://static.vecteezy.com/system/resources/thumbnails/048/938/460/small_2x/festival-concert-scene-crowd-from-dj-s-perspective-photo.jpeg',
    'https://jgu.edu.in/blog/wp-content/uploads/2023/12/shutterstock_1451879171.jpg',
    'https://static.vecteezy.com/system/resources/previews/022/006/618/non_2x/science-background-illustration-scientific-design-flasks-glass-and-chemistry-physics-elements-generative-ai-photo.jpeg',
    'https://st3.depositphotos.com/4318427/13503/i/450/depositphotos_135034544-stock-photo-boys-playing-soccer-young-football.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1932042689/display_1500/stock-photo-businessman-using-mobile-smart-phone-business-global-internet-connection-application-technology-1932042689.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    double cardHeight = height * 0.1;
    return SizedBox(
      height: cardHeight,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: category.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            CategoryPage(category: category[index]),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                              position: animation.drive(tween), child: child);
                        }));
              },
              child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Stack(
                    children: [
                      Container(
                        height: cardHeight,
                        width: width * 0.48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(img[index]),
                          ),
                        ),
                      ),
                      Container(
                        height: cardHeight,
                        width: width * 0.48,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            category[index],
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )),
            );
          }),
    );
  }
}
