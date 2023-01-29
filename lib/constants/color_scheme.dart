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
        case 5:
          return const Color(0xFFF3EED9).withOpacity(0.2);
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
        case 5:
          return const Color(0xFFF2DEBA).withOpacity(0.2);
      }
      break;

    case 2:
      switch (numcolor) {
        case 0:
          return const Color(0xFF282A3A);
        case 1:
          return const Color(0xFFE38072);
        case 2:
          return const Color(0xFFD1A617);
        case 3:
          return const Color(0xFFEBEEFF);
        case 4:
          return const Color(0xFFEBEEFF);
        case 5:
          return const Color(0xFF282A3A).withOpacity(0.2);
      }
      break;

    case 3:
      switch (numcolor) {
        case 0:
          return const Color(0xFF222831);
        case 1:
          return const Color(0xFFF05454);
        case 2:
          return const Color(0xFF2FAD8C);
        case 3:
          return const Color(0xFFDBF2FF);
        case 4:
          return const Color(0xFFDBF2FF);
        case 5:
          return const Color(0xFF222831).withOpacity(0.2);
      }
      break;

    case 999:
      switch (numcolor) {
        case 0:
          return Colors.red;
        case 1:
          return Colors.red;
        case 2:
          return Colors.red;
        case 3:
          return Colors.red;
        case 4:
          return Colors.red;
        case 5:
          return Colors.red;
      }
      break;
  }
}
