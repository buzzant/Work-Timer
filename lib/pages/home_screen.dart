import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';
import 'package:pomodoro_app/constants/date.dart';
import 'package:pomodoro_app/widgets/navigation_drawer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as devtools show log;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  static const workTime = 60;
  static const restTime = 60;

  int totalSeconds = workTime;
  int totalPomodoros = 0;
  int numColorScheme = 1;
  bool isRunning = false;
  bool isWorking = true;
  double turns = 0.0;
  late Timer timer;
  late AnimationController _controller;
  late SharedPreferences prefs;
  late int userTotalPomodoros;
  late int userTotalWorkTime;
  late int userTodayWorkTime;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    userTotalPomodoros = prefs.getInt('userTotalPomodoros') ?? 0;
    userTotalWorkTime = prefs.getInt('userTotalWorkTime') ?? 0;
    userTodayWorkTime = prefs.getInt(getDate()) ?? 0;
    final userTimebyDate = prefs.getStringList('userTimebyDate');
    if (userTimebyDate == null) {
      await prefs.setStringList('userTimebyDate', []);
    }
  }

  @override
  void initState() {
    initPrefs();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onTick(Timer timer) async {
    int userTotalPomodoros = prefs.getInt('userTotalPomodoros') ?? 0;
    int userTotalWorkTime = prefs.getInt('userTotalWorkTime') ?? 0;
    int userTodayWorkTime = prefs.getInt(getDate()) ?? 0;
    if (totalSeconds % 60 == 0 && isWorking && totalSeconds != workTime) {
      userTotalWorkTime = userTotalWorkTime + 1;
      userTodayWorkTime = userTodayWorkTime + 1;
      await prefs.setInt('userTotalWorkTime', userTotalWorkTime);
      await prefs.setInt(getDate(), userTodayWorkTime);
      devtools.log('today : $userTodayWorkTime , total : $userTotalWorkTime');
    }
    if (totalSeconds == 0) {
      setState(() {
        if (isWorking) {
          isWorking = !isWorking;
          totalSeconds = restTime;
          totalPomodoros = totalPomodoros + 1;
          userTotalPomodoros = userTotalPomodoros + 1;
        } else {
          isWorking = !isWorking;
          totalSeconds = workTime;
        }
      });
      await prefs.setInt('userTotalPomodoros', userTotalPomodoros);
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      if (isRunning) {
        isRunning = false;
        _controller.reverse();
      }
      isWorking = true;
      totalSeconds = workTime;
      totalPomodoros = 0;
      turns -= 1;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().substring(2, 7);
  }

  Color setColor(int numColorScheme, bool isWorking) {
    return isWorking
        ? setColorScheme(numScheme: numColorScheme, numcolor: 1)
        : setColorScheme(numScheme: numColorScheme, numcolor: 2);
  }

  Color setBackgroundColor(int numColorScheme) {
    return setColorScheme(
      numScheme: numColorScheme,
      numcolor: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(numScheme: numColorScheme),
      appBar: AppBar(
        foregroundColor: setColor(numColorScheme, isWorking),
        backgroundColor: setBackgroundColor(numColorScheme),
        elevation: 0,
      ),
      backgroundColor: setBackgroundColor(numColorScheme),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Text(
                  isWorking
                      ? (isRunning ? 'Working...' : 'Press Play to start timer')
                      : 'Taking a break...',
                  style: TextStyle(
                    color: setColor(numColorScheme, isWorking),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    format(totalSeconds),
                    style: TextStyle(
                      color: setColor(numColorScheme, isWorking),
                      fontSize: 89,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              children: [
                const SizedBox(height: 50),
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: totalSeconds.toDouble() /
                            (isWorking ? workTime : restTime),
                        strokeWidth: 15,
                        color: setColor(numColorScheme, isWorking),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (!isRunning) {
                                _controller.forward();
                                onStartPressed();
                              } else {
                                _controller.reverse();
                                onPausePressed();
                              }
                            },
                            child: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: _controller,
                              size: 75,
                              color: setColor(numColorScheme, isWorking),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 10),
                            child: Text(
                              '/',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: setColor(numColorScheme, isWorking),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: onResetPressed,
                            child: AnimatedRotation(
                              turns: turns,
                              duration: const Duration(milliseconds: 600),
                              child: Icon(
                                Icons.restart_alt_rounded,
                                size: 60,
                                color: setColor(numColorScheme, isWorking),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 5))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: setColor(numColorScheme, isWorking),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total Sessions',
                          style: TextStyle(
                            fontSize: 20,
                            color: setBackgroundColor(numColorScheme),
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color: setBackgroundColor(numColorScheme),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
