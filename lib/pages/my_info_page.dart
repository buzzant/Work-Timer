import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyInfoPage extends StatefulWidget {
  final int numScheme;
  const MyInfoPage({super.key, required this.numScheme});

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  late SharedPreferences prefs;

  //needs finishing
  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final userTotalPomodoros = prefs.getInt('userTotalPomodoros') ?? 0;
    final userTotalWorkTime = prefs.getInt('userTotalWorkTime') ?? 0;
    final userTimebyDate = prefs.getStringList('userTimebyDate');
    if (userTimebyDate == null) {
      await prefs.setStringList('userTimebyDate', []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Info',
            style: TextStyle(
                color:
                    setColorScheme(numScheme: widget.numScheme, numcolor: 3)),
          ),
          centerTitle: true,
          backgroundColor:
              setColorScheme(numScheme: widget.numScheme, numcolor: 0),
        ),
      ),
    );
  }
}
