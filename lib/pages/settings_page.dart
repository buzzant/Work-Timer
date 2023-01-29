import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';
import 'package:pomodoro_app/dialogs/color_select_dialog.dart';
import 'package:pomodoro_app/widgets/color_select_widget.dart';

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
        body: Column(
          children: [
            const Text('Set color'),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(ColorSelectRouteBuilder(0));
                    },
                    child: const Hero(
                      tag: 0,
                      child: ColorSelectWidget(numColorScheme: 0),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(ColorSelectRouteBuilder(1));
                    },
                    child: const Hero(
                      tag: 1,
                      child: ColorSelectWidget(numColorScheme: 1),
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
