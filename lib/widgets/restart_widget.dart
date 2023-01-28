import 'package:flutter/material.dart';

class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key});

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  double turns = 0.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: turns,
      duration: const Duration(milliseconds: 600),
      child: Icon(
        Icons.restart_alt_rounded,
        size: 40,
        color: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
