import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';
import 'package:pomodoro_app/pages/my_info_page.dart';
import 'package:pomodoro_app/pages/settings_page.dart';
import 'package:pomodoro_app/pages/about_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final int numScheme;
  const NavigationDrawerWidget({super.key, required this.numScheme});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: setColorScheme(numScheme: numScheme, numcolor: 0),
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
    Color color = setColorScheme(numScheme: numScheme, numcolor: 3);
    final hoverColor = setColorScheme(numScheme: numScheme, numcolor: 3);

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
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
