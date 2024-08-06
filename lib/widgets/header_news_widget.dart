import 'package:flutter/material.dart';

class HeaderNewsWidget extends StatelessWidget {
  const HeaderNewsWidget({
    super.key,
    required this.sheight,
    required this.swidth,
    required this.imgURL,
  });

  final double sheight;
  final double swidth;
  final String imgURL;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sheight * 0.55,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
                color: Colors.grey,
                child: Stack(children: [
                  Container(
                    width: swidth * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(imgURL)),
                    ),
                  ),
                  Positioned(
                    left: swidth * 0.1,
                    right: swidth * 0.1,
                    bottom: sheight * 0.05,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      height: sheight * 0.15,
                      width: swidth * 0.6,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Column(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Faite qui le voluptueux excitant non face et. «la son',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            children: [
                              Text('BBC News'),
                              Text('03/08/2024')
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ]));
          }),
    );
  }
}
