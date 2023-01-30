import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';

class SoundTile extends StatelessWidget {
  int index;
  int numColorScheme;
  SoundTile({super.key, required this.index, required this.numColorScheme});

  @override
  Widget build(BuildContext context) {
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Center(
        child: Text(
          soundList[index],
          style: TextStyle(
            color: setColorScheme(numScheme: numColorScheme, numcolor: 3),
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
