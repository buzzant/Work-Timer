import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/my_info_page.dart';
import 'package:pomodoro_app/pages/settings_page.dart';
import 'package:pomodoro_app/pages/about_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).colorScheme.background,
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(height: 48),
            buildMenuItem(
              text: 'My Info',
              icon: Icons.person_outline,
              onClicked: () => selectedItem(context, 0),
            ),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings,
              onClicked: () => selectedItem(context, 1),
            ),
            buildMenuItem(
              text: 'About',
              icon: Icons.info_outline_rounded,
              onClicked: () => selectedItem(context, 2),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.black;
    final hoverColor = Colors.black.withOpacity(0.8);

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MyInfoPage(),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SettingsPage(),
          ),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AboutPage(),
          ),
        );
        break;
    }
  }
}
