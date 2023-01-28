import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/home_screen.dart';
import 'package:pomodoro_app/widgets/navigation_drawer_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF3C537A),
          onPrimary: Color(0xFF79434F),
          secondary: Color(0xFF86A3B8),
          onSecondary: Color(0xFF86A3B8),
          error: Colors.black,
          onError: Colors.black,
          background: Color(0xFFF3EED9),
          onBackground: Color(0xFF476971),
          surface: Color(0xFFF55050),
          onSurface: Color(0xFF2F4858),
        ),
      ),
      home: Builder(
        builder: (context) {
          return Scaffold(
            drawer: const NavigationDrawerWidget(),
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              elevation: 0,
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            body: const HomeScreen(),
          );
        },
      ),
    );
  }
}
