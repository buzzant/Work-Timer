import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';
import 'package:pomodoro_app/widgets/navigation_drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  static const workTime = 500;
  static const restTime = 100;

  int totalSeconds = workTime;
  int totalPomodoros = 0;
  int numColorScheme = 1;
  bool isRunning = false;
  bool isWorking = true;
  double turns = 0.0;
  late Timer timer;
  late AnimationController _controller;

  @override
  void initState() {
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

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        if (isWorking) {
          isWorking = !isWorking;
          totalSeconds = restTime;
          totalPomodoros = totalPomodoros + 1;
        } else {
          isWorking = !isWorking;
          totalSeconds = workTime;
        }
      });
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
                  isWorking ? 'Working...' : 'Taking a break...',
                  style: TextStyle(
                    color: setColor(numColorScheme, isWorking),
                    fontSize: 20,
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
                        semanticsLabel: 'hi',
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
                          'Pomodoros',
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
