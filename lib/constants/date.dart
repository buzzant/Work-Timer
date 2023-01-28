import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as devtools show log;

String getDate() {
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(now);
}

String getPreviousDate(int diff) {
  var diffDate = DateTime.now().subtract(Duration(days: diff));
  var formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(diffDate);
}

String getNameofDate(int diff) {
  var diffDate = DateTime.now().subtract(Duration(days: diff));
  var formatter = DateFormat('EEEE');
  String longDate = formatter.format(diffDate);
  devtools.log(longDate);
  devtools.log(diff.toString());
  switch (longDate) {
    case 'Monday':
      return 'MON';
    case 'Tuesday':
      return 'TUE';
    case 'Wednesday':
      return 'WED';
    case 'Thursday':
      return 'THU';
    case 'Friday':
      return 'FRI';
    case 'Saturday':
      return 'SAT';
    case 'Sunday':
      return 'SUN';
    default:
      return 'name of date not found';
  }
}

class TimebyDate {
  final int index;
  final int timeofDate;

  TimebyDate({required this.index, required this.timeofDate});
}

Future<List<TimebyDate>> get timebyDate async {
  var workTimeList = <int>[];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  for (int i = 6; i >= 0; i--) {
    workTimeList.add(prefs.getInt(getPreviousDate(i)) ?? 0);
    devtools.log(i.toString());
    devtools.log(workTimeList.toString());
  }

  return workTimeList
      .mapIndexed((index, element) =>
          TimebyDate(index: index.toInt(), timeofDate: element))
      .toList();
}
