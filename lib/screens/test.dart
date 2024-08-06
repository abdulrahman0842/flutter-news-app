import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: const Color.fromARGB(122, 211, 211, 225),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
              child: Text(
                'Top Headlines',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
            ),
            SizedBox(
                height: height * 0.6,
                width: width * 0.99,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        height: height * 0.55,
                        width: width * 0.75,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg'))),
                        child: Stack(children: [
                          Positioned(
                              bottom: height * 0.7 / 20,
                              left: width * 0.7 / 15,
                              right: width * 0.7 / 15,
                              child: Container(
                                height: 200,
                                width: width * 0.7 / 1.2,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(122, 23, 37, 49),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.white)),
                              )),
                        ]),
                      ),
                    );
                  },
                ))
          ],
        ),
      )),
    );
  }
}

class NewsHeader extends StatelessWidget {
  const NewsHeader({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Card(
        child: Container(
          height: height * 0.6,
          width: width * 0.8,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg"))),
        ),
      ),
      Positioned(
          bottom: 110,
          left: width * 0.12,
          child: Container(
            padding: const EdgeInsets.all(15),
            height: height * 0.2,
            width: width * 0.6,
            decoration: BoxDecoration(
                color: const Color.fromARGB(48, 255, 255, 255),
                // border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(15)),
          )),
      Positioned(
          bottom: 100,
          left: width * 0.1,
          child: Container(
            padding: const EdgeInsets.all(15),
            height: height * 0.2,
            width: width * 0.6,
            decoration: BoxDecoration(
                color: const Color.fromARGB(62, 255, 255, 255),
                // border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(15)),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tesla Full Self-Driving data makes Elon Musk reduce expectations',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 2.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'BBC.com',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 9, 78, 135)),
                    ),
                    Text(
                      '2024-08-01',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                )
              ],
            ),
          ))
    ]);
  }
}
