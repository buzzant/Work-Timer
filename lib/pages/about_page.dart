import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';

class AboutPage extends StatelessWidget {
  final int numScheme;
  const AboutPage({super.key, required this.numScheme});

  @override
  Widget build(BuildContext context) => Material(
        child: Scaffold(
          backgroundColor: setColorScheme(numScheme: numScheme, numcolor: 0),
          appBar: AppBar(
            title: Text(
              'Settings',
              style: TextStyle(
                color: setColorScheme(numScheme: numScheme, numcolor: 3),
              ),
            ),
            centerTitle: true,
            elevation: 0,
            foregroundColor: setColorScheme(numScheme: numScheme, numcolor: 3),
            backgroundColor: setColorScheme(numScheme: numScheme, numcolor: 0),
          ),
        ),
      );
}
