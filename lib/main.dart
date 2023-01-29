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
}
