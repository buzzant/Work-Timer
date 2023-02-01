import 'package:flutter/material.dart';
import 'package:work_timer/constants/color_scheme.dart';
import 'package:work_timer/widgets/color_select_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

ColorSelectRouteBuilder(int numColorScheme) {
  return PageRouteBuilder(
    opaque: false,
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 500),
    barrierColor: setColorScheme(numScheme: numColorScheme, numcolor: 4),
    pageBuilder: (BuildContext context, _, __) {
      return AlertDialog(
        backgroundColor: setColorScheme(numScheme: numColorScheme, numcolor: 0),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: BorderSide(
            color: setColorScheme(numScheme: numColorScheme, numcolor: 7),
            width: 3,
          ),
        ),
        title: Text(
          'Select color',
          style: TextStyle(
            color: setColorScheme(numScheme: numColorScheme, numcolor: 3),
          ),
        ),
        content: SizedBox(
          height: 200,
          width: 200,
          child: Center(
            child: Hero(
              tag: numColorScheme,
              child: ColorSelectWidget(numColorScheme: numColorScheme),
            ),
          ),
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
                value.setInt('userColorScheme', numColorScheme);
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
