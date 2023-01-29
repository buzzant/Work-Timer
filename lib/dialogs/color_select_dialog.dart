import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';
import 'package:pomodoro_app/widgets/color_select_widget.dart';

ColorSelectRouteBuilder(int numColorScheme) {
  return PageRouteBuilder(
    opaque: false,
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 500),
    barrierColor: setColorScheme(numScheme: 1, numcolor: 5),
    pageBuilder: (BuildContext context, _, __) {
      return AlertDialog(
        backgroundColor: setColorScheme(numScheme: numColorScheme, numcolor: 0),
        elevation: 10,
        shadowColor: Colors.black,
        title: const Text('Select color'),
        content: Container(
          decoration: BoxDecoration(
              color: setColorScheme(numScheme: numColorScheme, numcolor: 0)),
          child: SizedBox(
            height: 200,
            width: 200,
            child: Center(
              child: Hero(
                tag: numColorScheme,
                child: ColorSelectWidget(numColorScheme: numColorScheme),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(
              'Cancel',
              style: TextStyle(
                color: setColorScheme(numScheme: numColorScheme, numcolor: 4),
              ),
            ),
          ),
          TextButton(
            onPressed: Navigator.of(context).pop,
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
