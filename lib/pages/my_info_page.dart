import 'package:flutter/material.dart';

class MyInfoPage extends StatelessWidget {
  const MyInfoPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('My Info'),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
}
