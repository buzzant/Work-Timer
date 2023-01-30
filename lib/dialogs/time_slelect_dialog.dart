import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';
import 'package:pomodoro_app/widgets/time_scroll_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as devtools show log;

TimeSelectRouteBuilder(
    int numColorScheme, int selectedHour, int selectedMin, int selectedSec) {
  FixedExtentScrollController controllerHour =
      FixedExtentScrollController(initialItem: selectedHour);
  FixedExtentScrollController controllerMin =
      FixedExtentScrollController(initialItem: selectedMin);
  FixedExtentScrollController controllerSec =
      FixedExtentScrollController(initialItem: selectedSec);

  int newHour = 0;
  int newMin = 0;
  int newSec = 0;

  return PageRouteBuilder(
    opaque: false,
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 500),
    barrierColor: setColorScheme(numScheme: numColorScheme, numcolor: 5),
    pageBuilder: (BuildContext context, _, __) {
      return AlertDialog(
        backgroundColor: setColorScheme(numScheme: numColorScheme, numcolor: 0),
        elevation: 10,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        title: Text(
          'Set Time',
          style: TextStyle(
            color: setColorScheme(numScheme: numColorScheme, numcolor: 3),
          ),
        ),
        content: Stack(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: setColorScheme(numScheme: numColorScheme, numcolor: 8),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const SizedBox(
                  width: 300,
                  height: 50,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //hours wheel
                SizedBox(
                  width: 50,
                  child: ListWheelScrollView.useDelegate(
                    onSelectedItemChanged: (value) {
                      newHour = value;
                    },
                    controller: controllerHour,
                    itemExtent: 50,
                    perspective: 0.003,
                    diameterRatio: 0.7,
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 13,
                      builder: (context, index) {
                        return TimeHours(
                          hours: index,
                          numColorScheme: numColorScheme,
                        );
                      },
                    ),
                  ),
                ),
                Text(
                  'hours',
                  style: TextStyle(
                    color:
                        setColorScheme(numScheme: numColorScheme, numcolor: 7),
                  ),
                ),
                //minutes wheel
                SizedBox(
                  width: 50,
                  child: ListWheelScrollView.useDelegate(
                    onSelectedItemChanged: (value) {
                      newMin = value;
                    },
                    controller: controllerMin,
                    itemExtent: 50,
                    perspective: 0.003,
                    diameterRatio: 0.7,
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 60,
                      builder: (context, index) {
                        return TimeMinutes(
                          mins: index,
                          numColorScheme: numColorScheme,
                        );
                      },
                    ),
                  ),
                ),
                Text(
                  'min',
                  style: TextStyle(
                    color:
                        setColorScheme(numScheme: numColorScheme, numcolor: 7),
                  ),
                ),
                //seconds wheel
                SizedBox(
                  width: 50,
                  child: ListWheelScrollView.useDelegate(
                    onSelectedItemChanged: (value) {
                      newSec = value;
                    },
                    controller: controllerSec,
                    itemExtent: 50,
                    perspective: 0.003,
                    diameterRatio: 0.7,
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 60,
                      builder: (context, index) {
                        return TimeSeconds(
                          sec: index,
                          numColorScheme: numColorScheme,
                        );
                      },
                    ),
                  ),
                ),
                Text(
                  'sec',
                  style: TextStyle(
                    color:
                        setColorScheme(numScheme: numColorScheme, numcolor: 7),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: setColorScheme(numScheme: numColorScheme, numcolor: 3),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              SharedPreferences.getInstance().then((value) {
                value.setInt(
                    'userWorkTime', newHour * 3600 + newMin * 60 + newSec);
                devtools
                    .log((newHour * 3600 + newMin * 60 + newSec).toString());
              });
            },
            child: Text(
              'Select',
              style: TextStyle(
                color: setColorScheme(numScheme: numColorScheme, numcolor: 1),
              ),
            ),
          )
        ],
      );
    },
  );
}
