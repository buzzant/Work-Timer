import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';
import 'package:pomodoro_app/widgets/sound_scroll_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

SoundSelectRouteBuilder(int numColorScheme, String currentSound) {
  final List<String> soundList = [
    'no_sound',
    'analog_alarm1',
    'analog_alarm2',
    'announcement1',
    'announcement2',
    'beep1',
    'beep2',
    'beep3',
    'beep4',
    'chicken',
    'ding',
    'honk',
    'horn',
    'notification1',
    'notification2',
    'surprise',
    'twinkle',
  ];
  FixedExtentScrollController controllerHour =
      FixedExtentScrollController(initialItem: soundList.indexOf(currentSound));

  String newSound = currentSound;

  return PageRouteBuilder(
    opaque: false,
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 500),
    barrierColor: setColorScheme(numScheme: numColorScheme, numcolor: 5),
    pageBuilder: (BuildContext context, _, __) {
      return AlertDialog(
        backgroundColor: setColorScheme(numScheme: numColorScheme, numcolor: 0),
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: BorderSide(
              color: setColorScheme(numScheme: numColorScheme, numcolor: 7),
              width: 3,
            )),
        title: Text(
          'Set Sound',
          style: TextStyle(
            color: setColorScheme(numScheme: numColorScheme, numcolor: 3),
          ),
        ),
        content: SizedBox(
          height: 350,
          width: 400,
          child: Stack(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        setColorScheme(numScheme: numColorScheme, numcolor: 8),
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
                  GestureDetector(
                    onTap: () async {
                      if (newSound != 'no_sound') {
                        final player = AudioPlayer();
                        await player.play(AssetSource('audio/$newSound.mp3'));
                      }
                    },
                    child: Icon(
                      Icons.play_circle_outline,
                      color: setColorScheme(
                          numScheme: numColorScheme, numcolor: 2),
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 20),
                  //hours wheel
                  SizedBox(
                    width: 150,
                    child: ListWheelScrollView.useDelegate(
                      onSelectedItemChanged: (value) {
                        newSound = soundList[value];
                      },
                      controller: controllerHour,
                      itemExtent: 50,
                      perspective: 0.003,
                      diameterRatio: 0.60,
                      physics: const FixedExtentScrollPhysics(),
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 17,
                        builder: (context, index) {
                          return SoundTile(
                            index: index,
                            numColorScheme: numColorScheme,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
                value.setString('userAlarmSound', newSound);
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
