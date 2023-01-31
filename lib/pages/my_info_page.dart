import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';
import 'package:pomodoro_app/constants/date.dart';
import 'package:pomodoro_app/widgets/bar_chart_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as devtools show log;

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({super.key});

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  int userTotalPomodoros = 9999;
  int userTotalWorkTime = 9999;
  int userColorScheme = 999;

  List<int> workTimeList = <int>[];

  //needs finishing on time by Date
  initPrefs() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        userTotalPomodoros = value.getInt('userTotalPomodoros') ?? 0;
        userTotalWorkTime = value.getInt('userTotalWorkTime') ?? 0;
        userColorScheme = value.getInt('userColorScheme') ?? 0;
        devtools.log('info page : ${userColorScheme.toString()}');
        //below needs work
      });
    });
  }

  initData() {
    SharedPreferences.getInstance().then((value) {
      for (int i = 6; i >= 0; i--) {
        workTimeList.add(value.getInt(getPreviousDate(i)) ?? 0);
        devtools.log((value.getInt(getPreviousDate(i)) ?? 0).toString());
      }
    });
  }

  @override
  void initState() {
    initPrefs();
    initData();
    super.initState();
  }

  String formatHours(int seconds) {
    int hour = seconds ~/ 3600;
    var f = NumberFormat('#######');
    return f.format(hour).toString();
  }

  String formatMinutes(int seconds) {
    int min = (seconds % 3600) ~/ 60;
    var f = NumberFormat('#######');
    return f.format(min).toString();
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
            'My Info',
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
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
                              numScheme: userColorScheme, numcolor: 3),
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
                                  numScheme: userColorScheme, numcolor: 1),
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
                              numScheme: userColorScheme, numcolor: 3),
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
                                  numScheme: userColorScheme, numcolor: 1),
                              fontSize: 50,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'h ',
                            style: TextStyle(
                              color: setColorScheme(
                                  numScheme: userColorScheme, numcolor: 3),
                              fontSize: 50,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            formatMinutes(userTotalWorkTime),
                            style: TextStyle(
                              color: setColorScheme(
                                  numScheme: userColorScheme, numcolor: 1),
                              fontSize: 50,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'm ',
                            style: TextStyle(
                              color: setColorScheme(
                                  numScheme: userColorScheme, numcolor: 3),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: FutureBuilder(
                      future: timebyDate,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return BarChartSample1(
                            userColorScheme: userColorScheme,
                            workTimeList: workTimeList,
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
