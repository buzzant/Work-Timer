import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as devtools show log;

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int userColorScheme = 999;

  initPrefs() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        userColorScheme = value.getInt('userColorScheme') ?? 0;
        devtools.log('about page : ${userColorScheme.toString()}');
      });
    });
  }

  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor:
            setColorScheme(numScheme: userColorScheme, numcolor: 0),
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: setColorScheme(numScheme: userColorScheme, numcolor: 3),
            ),
            onTap: () {
              Navigator.of(context).pop(false);
            },
          ),
          title: Text(
            'About',
            style: TextStyle(
              color: setColorScheme(numScheme: userColorScheme, numcolor: 3),
            ),
          ),
          centerTitle: true,
          elevation: 1,
          foregroundColor:
              setColorScheme(numScheme: userColorScheme, numcolor: 3),
          backgroundColor:
              setColorScheme(numScheme: userColorScheme, numcolor: 0),
        ),
      ),
    );
  }
}
