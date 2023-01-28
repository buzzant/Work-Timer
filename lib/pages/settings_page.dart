import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';

class SettingsPage extends StatefulWidget {
  final int numScheme;
  const SettingsPage({super.key, required this.numScheme});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor:
            setColorScheme(numScheme: widget.numScheme, numcolor: 0),
        appBar: AppBar(
          title: Text(
            'Settings',
            style: TextStyle(
              color: setColorScheme(numScheme: widget.numScheme, numcolor: 3),
            ),
          ),
          centerTitle: true,
          elevation: 0,
          foregroundColor:
              setColorScheme(numScheme: widget.numScheme, numcolor: 3),
          backgroundColor:
              setColorScheme(numScheme: widget.numScheme, numcolor: 0),
        ),
      ),
    );
  }
}
