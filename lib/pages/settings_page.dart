import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';
import 'package:pomodoro_app/dialogs/color_select_dialog.dart';
import 'package:pomodoro_app/widgets/color_select_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as devtools show log;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int userColorScheme = 999;

  initPrefs() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        userColorScheme = value.getInt('userColorScheme') ?? 0;
        devtools.log('settings page : ${userColorScheme.toString()}');
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
    initPrefs();
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
            'Settings',
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
          children: [
            const SizedBox(height: 20),
            Text(
              'Set color',
              style: TextStyle(
                color: setColorScheme(numScheme: userColorScheme, numcolor: 3),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: setColorScheme(
                          numScheme: userColorScheme, numcolor: 4),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        width: 4,
                        color: userColorScheme == 0
                            ? setColorScheme(
                                numScheme: userColorScheme, numcolor: 1)
                            : setColorScheme(
                                numScheme: userColorScheme, numcolor: 4),
                      ),
                    ),
                    child: SizedBox(
                      height: 160,
                      width: 160,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(ColorSelectRouteBuilder(0))
                                .then((value) => initPrefs());
                          },
                          child: const Hero(
                            tag: 0,
                            child: ColorSelectWidget(numColorScheme: 0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: setColorScheme(
                          numScheme: userColorScheme, numcolor: 4),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        width: 4,
                        color: userColorScheme == 1
                            ? setColorScheme(
                                numScheme: userColorScheme, numcolor: 1)
                            : setColorScheme(
                                numScheme: userColorScheme, numcolor: 4),
                      ),
                    ),
                    child: SizedBox(
                      height: 160,
                      width: 160,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(ColorSelectRouteBuilder(1))
                                .then((value) => initPrefs());
                          },
                          child: const Hero(
                            tag: 1,
                            child: ColorSelectWidget(numColorScheme: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: setColorScheme(
                          numScheme: userColorScheme, numcolor: 4),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        width: 4,
                        color: userColorScheme == 2
                            ? setColorScheme(
                                numScheme: userColorScheme, numcolor: 1)
                            : setColorScheme(
                                numScheme: userColorScheme, numcolor: 4),
                      ),
                    ),
                    child: SizedBox(
                      height: 160,
                      width: 160,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(ColorSelectRouteBuilder(2))
                                .then((value) => initPrefs());
                          },
                          child: const Hero(
                            tag: 2,
                            child: ColorSelectWidget(numColorScheme: 2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: setColorScheme(
                          numScheme: userColorScheme, numcolor: 4),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        width: 4,
                        color: userColorScheme == 3
                            ? setColorScheme(
                                numScheme: userColorScheme, numcolor: 1)
                            : setColorScheme(
                                numScheme: userColorScheme, numcolor: 4),
                      ),
                    ),
                    child: SizedBox(
                      height: 160,
                      width: 160,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(ColorSelectRouteBuilder(3))
                                .then((value) => initPrefs());
                          },
                          child: const Hero(
                            tag: 3,
                            child: ColorSelectWidget(numColorScheme: 3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
