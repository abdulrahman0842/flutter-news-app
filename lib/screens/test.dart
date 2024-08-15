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
      backgroundColor: Colors.grey,
      body: SafeArea(
          child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: horiz(height: height, width: width),
          ),
          SliverToBoxAdapter(child: NewWidget(height: height, width: width))
        ],
      )),
    );
  }
}

class horiz extends StatelessWidget {
  const horiz({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
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
                      padding: const EdgeInsets.all(8),
                      height: 200,
                      width: width * 0.7 / 1.2,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(122, 23, 37, 49),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Unavailable',
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Unknown',
                                  style: TextStyle(color: Colors.white)),
                              Text('date',
                                  style: TextStyle(color: Colors.white))
                            ],
                          )
                        ],
                      ),
                    )),
              ]),
            ),
          );
        },
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.height,
    required this.width,
  });
 
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.99,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
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
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg'))),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                height: MediaQuery.sizeOf(context).width * 0.3,
                width: 180,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UnAvailable',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text("Unknown",
                              maxLines: 2,
                              style: TextStyle(color: Colors.blue)),
                        ),
                        Flexible(
                          child: Text('UnAvaible',
                              style: TextStyle(color: Colors.white)),
                        )
                      ],
                    )
                  ],
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}
