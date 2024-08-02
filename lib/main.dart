import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testing/home.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) {
      exit(1);
    }
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API Calls',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 117, 33, 33)),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   StreamController<String> streamController = StreamController<String>();
//   late Stream<String> dataStream;
//   TextEditingController textEditingController = TextEditingController();
//   @override
//   void initState() {
//     dataStream = streamController.stream.asBroadcastStream();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             StreamBuilder<String>(
//               stream: dataStream,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Text(snapshot.data ?? 'Null');
//                 } else {
//                   return Text('No Data');
//                 }
//               },
//             ),
//             StreamBuilder<String>(
//               stream: dataStream,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Text(snapshot.data ?? 'Null');
//                 } else {
//                   return Text('No Data');
//                 }
//               },
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             SizedBox(
//                 width: 200,
//                 child: TextField(
//                   controller: textEditingController,
//                 )),
//             const SizedBox(
//               height: 10,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   streamController.add(textEditingController.text);
//                   textEditingController.clear();
//                 },
//                 child: Text('Tap'))
//           ],
//         ),
//       ),
//     );
//   }
// }
