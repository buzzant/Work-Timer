import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';
import 'package:pomodoro_app/constants/date.dart';
import 'package:pomodoro_app/pages/about_page.dart';
import 'package:pomodoro_app/pages/my_info_page.dart';
import 'package:pomodoro_app/pages/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as devtools show log;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int totalPomodoros = 0;
  bool isRunning = false;
  bool isWorking = true;
  double turns = 0.0;
  late Timer timer;
  late AnimationController _controller;
  late SharedPreferences prefs;
  int userTotalPomodoros = 9999;
  int userTotalWorkTime = 9999;
  int userTodayWorkTime = 9999;
  int userColorScheme = 999;
  int userWorkTime = 999;
  int userRestTime = 999;
  int totalSeconds = 9999;
  int cnt = 0;
  String userAlarmSound = 'analog_alarm1';
  late AudioPlayer _player;

  initPrefs() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        userTotalPomodoros = value.getInt('userTotalPomodoros') ?? 0;
        userTotalWorkTime = value.getInt('userTotalWorkTime') ?? 0;
        userTodayWorkTime = value.getInt(getDate()) ?? 0;
        userColorScheme = value.getInt('userColorScheme') ?? 0;
        userWorkTime = value.getInt('userWorkTime') ?? 1500;
        userRestTime = value.getInt('userRestTime') ?? 300;
        totalSeconds = userWorkTime;
        userAlarmSound = value.getString('userAlarmSound') ?? 'no_sound';
        devtools.log('home screen : ${userColorScheme.toString()}');
      });
    });
  }

  initPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initPrefs();
    initPref();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _player = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _player.dispose();
    super.dispose();
  }

  void onTick(Timer timer) async {
    if (isWorking) {
      cnt += 1;
      if (cnt == 10) {
        userTodayWorkTime += cnt;
        userTotalWorkTime += cnt;
        cnt = 0;
        await prefs.setInt(getDate(), userTodayWorkTime);
        await prefs.setInt('userTotalWorkTime', userTotalWorkTime);
        devtools.log('today : $userTodayWorkTime , total : $userTotalWorkTime');
      }
    }
    if (totalSeconds == 0) {
      if (userAlarmSound != 'no_sound') {
        await _player.play(AssetSource('audio/$userAlarmSound.mp3'));
      }
      setState(() {
        if (isWorking) {
          isWorking = !isWorking;
          totalSeconds = userRestTime;
          totalPomodoros = totalPomodoros + 1;
          userTotalPomodoros = userTotalPomodoros + 1;
        } else {
          isWorking = !isWorking;
          totalSeconds = userWorkTime;
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
      totalSeconds = userWorkTime;
      totalPomodoros = 0;
      turns -= 1;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    if (seconds < 3600) {
      return duration.toString().substring(2, 7);
    } else if (seconds >= 43200) {
      return duration.toString().substring(0, 8);
    } else {
      return duration.toString().substring(0, 7);
    }
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

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    Color color = setColorScheme(numScheme: userColorScheme, numcolor: 3);
    final hoverColor = setColorScheme(numScheme: userColorScheme, numcolor: 3);

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Material(
          color: setColorScheme(numScheme: userColorScheme, numcolor: 0),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              const SizedBox(height: 48),
              buildMenuItem(
                  text: 'My Info',
                  icon: Icons.person_outline,
                  onClicked: () async {
                    Navigator.of(context).pop();
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MyInfoPage(),
                      ),
                    );
                    SharedPreferences.getInstance().then((value) {
                      setState(() {
                        userColorScheme = value.getInt('userColorScheme') ?? 0;
                        devtools
                            .log('exit info : ${userColorScheme.toString()}');
                      });
                    });
                  }),
              buildMenuItem(
                  text: 'Settings',
                  icon: Icons.settings,
                  onClicked: () async {
                    Navigator.of(context).pop();
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );

                    SharedPreferences.getInstance().then((value) {
                      setState(() {
                        userColorScheme = value.getInt('userColorScheme') ?? 0;
                        int usernewWorkTime =
                            value.getInt('userWorkTime') ?? 1500;
                        userRestTime = value.getInt('userRestTime') ?? 300;

                        devtools.log(
                            'exit settings : ${userColorScheme.toString()}, ${userWorkTime.toString()}, ${userRestTime.toString()}, ');
                        if (usernewWorkTime != userWorkTime) {
                          if (isRunning) {
                            isRunning = false;
                            _controller.reverse();
                          }
                          timer.cancel();
                          isWorking = true;
                          totalPomodoros = 0;
                          totalSeconds = usernewWorkTime;
                          userWorkTime = usernewWorkTime;
                        }
                      });
                    });
                  }),
              buildMenuItem(
                  text: 'About',
                  icon: Icons.info_outline_rounded,
                  onClicked: () async {
                    initPrefs();
                    Navigator.of(context).pop();
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AboutPage(),
                      ),
                    );
                    SharedPreferences.getInstance().then((value) {
                      setState(() {
                        userColorScheme = value.getInt('userColorScheme') ?? 0;
                        devtools
                            .log('exit about : ${userColorScheme.toString()}');
                      });
                    });
                  }),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        foregroundColor: setColor(userColorScheme, isWorking),
        backgroundColor: setBackgroundColor(userColorScheme),
        elevation: 0,
      ),
      backgroundColor: setBackgroundColor(userColorScheme),
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
                    color: setColor(userColorScheme, isWorking),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    format(totalSeconds),
                    style: TextStyle(
                      color: setColor(userColorScheme, isWorking),
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
                            (isWorking ? userWorkTime : userRestTime),
                        strokeWidth: 15,
                        color: setColor(userColorScheme, isWorking),
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
                              color: setColor(userColorScheme, isWorking),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 10),
                            child: Text(
                              '/',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: setColor(userColorScheme, isWorking),
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
                                color: setColor(userColorScheme, isWorking),
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
                      color: setColor(userColorScheme, isWorking),
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
                            color: setBackgroundColor(userColorScheme),
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color: setBackgroundColor(userColorScheme),
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
