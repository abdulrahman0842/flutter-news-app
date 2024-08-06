import 'package:flutter/material.dart';

class Tele extends StatefulWidget {
  const Tele({super.key});

  @override
  State<Tele> createState() => _TeleState();
}

class _TeleState extends State<Tele> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50),
            SizedBox(
              height: 650,
              width: 400,
              child: Card(
                elevation: 20,
                child: Container(
                  height: 700,
                  // width: 200,
                  // margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey,
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://img.freepik.com/premium-photo/street-new-york-city-view-beautiful_389847-8.jpg'))),
                  child: Stack(
                    children: [
                      Positioned(
                          bottom: 1,
                          left: 50,
                          child: Container(
                              height: 150, width: 150, color: Colors.blue))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
