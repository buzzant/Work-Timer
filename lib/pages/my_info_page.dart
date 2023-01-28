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
  // late Future<SharedPreferences> prefs;
  // late Future<int> prefsUserTotalPomodoros;
  int userTotalPomodoros = 9999;
  // late int userTotalWorkTime = 9999;

  //needs finishing on time by Date
  initPrefs() {
    // Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    // final SharedPreferences prefs = await prefs0;
    // prefs.getInt('userTotalWorkTime');
    // prefs.getInt('userTotalPomodoros');
    SharedPreferences.getInstance().then((value) {
      setState(() {
        userTotalPomodoros = value.getInt('userTotalPomodoros') ?? 0;
      });
    });
    // userTotalWorkTime = prefs.getInt('userTotalWorkTime') ?? 0;
    // final userTimebyDate = prefs.getStringList('userTimebyDate');
    // if (userTimebyDate == null) {
    //   await prefs.setStringList('userTimebyDate', []);
    // }
  }

  // dynamic getTotalPomodoros() async {
  //   Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
  //   final SharedPreferences prefs = await prefs0;
  //   int res = prefs.getInt('userTotalPomodoros') ?? 0;
  //   print(res.toString());
  //   return res;
  // }

  @override
  void initState() {
    initPrefs();
    super.initState();
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
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Column(
                    children: [
                      const Text('Total Work Time'),
                      Text(userTotalPomodoros.toString()),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Column(
                    children: [
                      const Text('Total Work Time'),
                      Text(userTotalPomodoros.toString()),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
