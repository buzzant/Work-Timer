import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // testAudio() async {
  //   final player = AudioPlayer();
  //   await player.play(AssetSource('audio/clock-alarm-8761.mp3'));
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       body: Center(
  //         child: TextButton(
  //           onPressed: () async {
  //             final player = AudioPlayer();
  //             await player.play(AssetSource('audio/clock-alarm-8761.mp3'));
  //           },
  //           child: const Text('play'),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return const HomeScreen();
        },
      ),
    );
  }
}
