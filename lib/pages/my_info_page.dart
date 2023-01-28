import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';
import 'package:pomodoro_app/constants/date.dart';
import 'package:pomodoro_app/widgets/bar_chart_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as devtools show log;

class MyInfoPage extends StatefulWidget {
  final int numScheme;
  const MyInfoPage({super.key, required this.numScheme});

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  int userTotalPomodoros = 9999;
  int userTotalWorkTime = 9999;

  //needs finishing on time by Date
  initPrefs() {
    // Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    // final SharedPreferences prefs = await prefs0;
    // prefs.getInt('userTotalWorkTime');
    // prefs.getInt('userTotalPomodoros');
    SharedPreferences.getInstance().then((value) {
      setState(() {
        userTotalPomodoros = value.getInt('userTotalPomodoros') ?? 0;
        userTotalWorkTime = value.getInt('userTotalWorkTime') ?? 0;
        for (int i = 0; i < 7; i++) {}
        devtools.log(userTotalWorkTime.toString());
      });
    });
  }

  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  String formatHours(int minutes) {
    int hour = minutes ~/ 60;
    var f = NumberFormat('#######');
    return f.format(hour).toString();
  }

  String formatMinutes(int minutes) {
    int min = minutes % 60;
    var f = NumberFormat('#######');
    return f.format(min).toString();
  }

  // getUserTime(int cases) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   switch (cases) {
  //     case 0:
  //       return prefs.getInt('userTotalPomodors') ?? 0;
  //     case 1:
  //       return prefs.getInt('userTotalWorkTime') ?? 0;
  //     default:
  //       throw PreferencesDataNotFoundException();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor:
            setColorScheme(numScheme: widget.numScheme, numcolor: 0),
        appBar: AppBar(
          title: Text(
            'My Info',
            style: TextStyle(
              color: setColorScheme(numScheme: widget.numScheme, numcolor: 3),
            ),
          ),
          centerTitle: true,
          elevation: 0,
          foregroundColor:
              setColorScheme(numScheme: widget.numScheme, numcolor: 3),
          backgroundColor:
              setColorScheme(numScheme: widget.numScheme, numcolor: 0),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Column(
                    children: [
                      Text(
                        'Total Sessions',
                        style: TextStyle(
                          color: setColorScheme(
                              numScheme: widget.numScheme, numcolor: 4),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userTotalPomodoros.toString(),
                            style: TextStyle(
                              color: setColorScheme(
                                  numScheme: widget.numScheme, numcolor: 3),
                              fontSize: 50,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Column(
                    children: [
                      Text(
                        'Total Work Time',
                        style: TextStyle(
                          color: setColorScheme(
                              numScheme: widget.numScheme, numcolor: 4),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            formatHours(userTotalWorkTime),
                            style: TextStyle(
                              color: setColorScheme(
                                  numScheme: widget.numScheme, numcolor: 3),
                              fontSize: 50,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'h ',
                            style: TextStyle(
                              color: setColorScheme(
                                  numScheme: widget.numScheme, numcolor: 4),
                              fontSize: 50,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            formatMinutes(userTotalWorkTime),
                            style: TextStyle(
                              color: setColorScheme(
                                  numScheme: widget.numScheme, numcolor: 3),
                              fontSize: 50,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'm ',
                            style: TextStyle(
                              color: setColorScheme(
                                  numScheme: widget.numScheme, numcolor: 4),
                              fontSize: 50,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                children: [
                  const Text("This Week's Work Time"),
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: FutureBuilder(
                      future: timebyDate,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return BarChartWidget(
                            points: snapshot.data!,
                            numScheme: widget.numScheme,
                          );
                        } else {
                          return const Text('...');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
