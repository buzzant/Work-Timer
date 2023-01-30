import 'package:flutter/material.dart';

setColorScheme({required int numScheme, required int numcolor}) {
  switch (numScheme) {
    case 0:
      switch (numcolor) {
        case 0:
          //background color
          return const Color(0xFFF3EED9);
        case 1:
          //work time color
          return const Color(0xFFF98E72);
        case 2:
          //rest time color
          return const Color(0xFF3C537A);
        case 3:
          //text color
          return const Color(0xFF2F4858);
        case 4:
          //background color for color select dialog
          return const Color(0xFFF3EED9).withOpacity(0.5);
        case 5:
          //color for outside of color select dialog
          return const Color(0xFFF3EED9).withOpacity(0.2);
        case 6:
          //color for graph background
          return const Color(0xFF4E4637);
        case 7:
          //color for info text
          return Colors.black;
        case 8:
          //work time color
          return const Color(0xFFF98E72).withOpacity(0.15);
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
          return const Color(0xFFF2DEBA).withOpacity(0.5);
        case 5:
          return const Color(0xFFF2DEBA).withOpacity(0.2);
        case 6:
          return const Color(0xFF4E4637);
        case 7:
          return Colors.black;
        case 8:
          return const Color(0xFF820000).withOpacity(0.15);
      }
      break;

    case 2:
      switch (numcolor) {
        case 0:
          return const Color(0xFF282A3A);
        case 1:
          return const Color(0xFFE38072);
        case 2:
          return const Color(0xFFF7C840);
        case 3:
          return const Color(0xFFEBEEFF);
        case 4:
          return const Color(0xFF282A3A).withOpacity(0.5);
        case 5:
          return const Color(0xFF282A3A).withOpacity(0.2);
        case 6:
          return const Color(0xFF604463);
        case 7:
          return Colors.white;
        case 8:
          return const Color(0xFFE38072).withOpacity(0.15);
      }
      break;

    case 3:
      switch (numcolor) {
        case 0:
          return const Color(0xFF222831);
        case 1:
          return const Color(0xFFE9B9D1);
        case 2:
          return const Color(0xFFA1ACBD);
        case 3:
          return const Color(0xFFDBF2FF);
        case 4:
          return const Color(0xFF222831).withOpacity(0.5);
        case 5:
          return const Color(0xFF222831).withOpacity(0.2);
        case 6:
          return const Color(0xFF1F5063);
        case 7:
          return Colors.white;
        case 8:
          return const Color(0xFFE9B9D1).withOpacity(0.15);
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
