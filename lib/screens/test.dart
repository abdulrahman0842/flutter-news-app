import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final List<String> img = [
    'https://online.hbs.edu/Style%20Library/api/resize.aspx?imgpath=/PublishingImages/overhead-view-of-business-strategy-meeting.jpg&w=1200&h=630',
    'https://static.vecteezy.com/system/resources/thumbnails/048/938/460/small_2x/festival-concert-scene-crowd-from-dj-s-perspective-photo.jpeg',
    'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg',
    'https://static.vecteezy.com/system/resources/previews/022/006/618/non_2x/science-background-illustration-scientific-design-flasks-glass-and-chemistry-physics-elements-generative-ai-photo.jpeg',
    'https://st3.depositphotos.com/4318427/13503/i/450/depositphotos_135034544-stock-photo-boys-playing-soccer-young-football.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1932042689/display_1500/stock-photo-businessman-using-mobile-smart-phone-business-global-internet-connection-application-technology-1932042689.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        body: ListView.builder(
            itemCount: img.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.all(8),
                child: Container(
                  height: height * 0.20,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                          image: NetworkImage(img[index]), fit: BoxFit.cover)),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.black54),
                    child: const Text(
                      'Diam dolores dolor stet tempor sadipscing voluptua no no rebum accusam. Erat at et sanctus accusam. Voluptua sed vero consetetur.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            }));
  }

  Container newMethod(double height, double width) {
    return Container(
      padding: const EdgeInsets.all(8),

      // color: Colors.green,
      child: Column(
        children: [
          Container(
            height: height * 0.33,
            width: width * 0.99,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(50)),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: width * 0.95,
            child: const Text(
              'Kasd no et eos dolor sanctus tempor ea dolor eirmod clita. Erat.Accusam clita stet ea clita tempor et, elitr ea sit justo clita.',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
