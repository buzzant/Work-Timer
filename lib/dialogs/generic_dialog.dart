import 'package:flutter/material.dart';
import 'package:pomodoro_app/widgets/color_select_widget.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required int numColorScheme,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Hero(
          tag: numColorScheme,
          child: ColorSelectWidget(numColorScheme: numColorScheme),
        ),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return TextButton(
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(optionTitle),
          );
        }).toList(),
      );
    },
  );
}

Future<bool> colorSelectDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Select this Color?',
    numColorScheme: 1,
    optionsBuilder: () => {
      'Cancel': false,
      'Select': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
