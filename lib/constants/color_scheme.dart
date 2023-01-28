import 'package:flutter/material.dart';

setColorScheme({required int numScheme, required int numcolor}) {
  switch (numScheme) {
    case 0:
      switch (numcolor) {
        case 0:
          return const Color(0xFFF3EED9);
        case 1:
          return const Color(0xFFF55050);
        case 2:
          return const Color(0xFF3C537A);
        case 3:
          return const Color(0xFF2F4858);
        case 4:
          return Colors.black;
      }
      break;
    case 1:
      switch (numcolor) {
        case 0:
          return const Color(0xFFF2DEBA);
        case 1:
          return const Color(0xFF820000);
        case 2:
          return const Color(0xFF4E6C50);
        case 3:
          return const Color(0xFF2F4858);
        case 4:
          return const Color(0xFF402E32);
      }
      break;
  }
}
