import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return const HomeScreen();
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Builder(
  //       builder: (context) {
  //         return MaterialApp(
  //           home: Scaffold(
  //             body: Container(
  //               decoration: BoxDecoration(
  //                   color: setColorScheme(numScheme: 1, numcolor: 0)),
  //               child: Center(
  //                 child: Column(
  //                   children: [
  //                     const Hero(
  //                       tag: 1,
  //                       child: ColorSelectWidget(numColorScheme: 1),
  //                     ),
  //                     TextButton(
  //                       onPressed: () {
  //                         Navigator.of(context)
  //                             .push(ColorSelectRouteBuilder(1));
  //                       },
  //                       child: const Text(
  //                         'open dialog',
  //                         style: TextStyle(fontSize: 30),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
