import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/home_screen.dart';
import 'package:intl/intl.dart';

void main() {
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);
  print(formattedDate);
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
