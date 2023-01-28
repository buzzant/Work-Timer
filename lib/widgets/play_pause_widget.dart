import 'package:flutter/material.dart';

class PlayPauseWidget extends StatefulWidget {
  const PlayPauseWidget({super.key});

  @override
  State<PlayPauseWidget> createState() => _PlayPauseWidgetState();
}

class _PlayPauseWidgetState extends State<PlayPauseWidget>
    with TickerProviderStateMixin {
  bool _isPlay = false;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_isPlay) {
          _controller.forward();
          _isPlay = true;
        } else {
          _controller.reverse();
          _isPlay = false;
        }
      },
      child: AnimatedIcon(
        icon: AnimatedIcons.play_pause,
        progress: _controller,
        size: 50,
        color: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
