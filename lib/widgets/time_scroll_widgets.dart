import 'package:flutter/material.dart';
import 'package:work_timer/constants/color_scheme.dart';

class TimeHours extends StatelessWidget {
  int hours;
  int numColorScheme;
  TimeHours({super.key, required this.hours, required this.numColorScheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Center(
        child: Text(
          hours < 10 ? '0$hours' : '$hours',
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

class TimeMinutes extends StatelessWidget {
  int mins;
  int numColorScheme;
  TimeMinutes({super.key, required this.mins, required this.numColorScheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Center(
        child: Text(
          mins < 10 ? '0$mins' : '$mins',
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

class TimeSeconds extends StatelessWidget {
  int sec;
  int numColorScheme;
  TimeSeconds({super.key, required this.sec, required this.numColorScheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Center(
        child: Text(
          sec < 10 ? '0$sec' : '$sec',
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
