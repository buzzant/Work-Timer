import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';

class ColorSelectWidget extends StatefulWidget {
  final int numColorScheme;
  const ColorSelectWidget({super.key, required this.numColorScheme});

  @override
  State<ColorSelectWidget> createState() => _ColorSelectWidgetState();
}

class _ColorSelectWidgetState extends State<ColorSelectWidget> {
  final double _height = 150;
  final double _width = 150;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: Column(
        children: [
          SizedBox(
            height: _height / 3,
            child: Container(
              decoration: BoxDecoration(
                color: setColorScheme(
                    numScheme: widget.numColorScheme, numcolor: 1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
          ),
          SizedBox(
            height: _height / 3,
            child: Container(
              decoration: BoxDecoration(
                color: setColorScheme(
                    numScheme: widget.numColorScheme, numcolor: 0),
              ),
            ),
          ),
          SizedBox(
            height: _height / 3,
            child: Container(
              decoration: BoxDecoration(
                color: setColorScheme(
                    numScheme: widget.numColorScheme, numcolor: 2),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
