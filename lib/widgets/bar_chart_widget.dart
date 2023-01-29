// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:pomodoro_app/constants/color_scheme.dart';
// import 'package:pomodoro_app/constants/date.dart';

// class BarChartWidget extends StatefulWidget {
//   final int numScheme;
//   const BarChartWidget(
//       {Key? key, required this.points, required this.numScheme})
//       : super(key: key);

//   final List<TimebyDate> points;

//   @override
//   State<BarChartWidget> createState() => _BarChartWidgetState(points: points);
// }

// class _BarChartWidgetState extends State<BarChartWidget> {
//   final List<TimebyDate> points;

//   _BarChartWidgetState({required this.points});

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 4,
//       child: BarChart(
//         BarChartData(
//           backgroundColor:
//               setColorScheme(numScheme: widget.numScheme, numcolor: 0),
//           barGroups: _chartGroups(),
//           borderData: FlBorderData(border: const Border(bottom: BorderSide())),
//           gridData: FlGridData(show: false),
//           titlesData: FlTitlesData(
//             bottomTitles: AxisTitles(sideTitles: _bottomTitles),
//             leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           ),
//         ),
//       ),
//     );
//   }

//   List<BarChartGroupData> _chartGroups() {
//     return points
//         .map((point) => BarChartGroupData(
//             x: point.index.toInt(),
//             barRods: [BarChartRodData(toY: point.timeofDate.toDouble())]))
//         .toList();
//   }

//   SideTitles get _bottomTitles => SideTitles(
//         showTitles: true,
//         getTitlesWidget: (value, meta) {
//           String text = getNameofDate((6 - value).toInt());
//           return Text(text);
//         },
//       );
// }
import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';
import 'package:pomodoro_app/constants/date.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarChartSample1 extends StatefulWidget {
  int userColorScheme;
  List<int> workTimeList;
  BarChartSample1(
      {super.key, required this.userColorScheme, required this.workTimeList});

  List<Color> get availableColors => <Color>[
        setColorScheme(numScheme: userColorScheme, numcolor: 0),
        setColorScheme(numScheme: userColorScheme, numcolor: 1),
        setColorScheme(numScheme: userColorScheme, numcolor: 2),
        setColorScheme(numScheme: userColorScheme, numcolor: 3),
        setColorScheme(numScheme: userColorScheme, numcolor: 4),
      ];

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  late SharedPreferences prefs;

  Color barBackgroundColor = Colors.red;
  Color barColor = Colors.red;
  Color touchedBarColor = Colors.red;

  @override
  void initState() {
    super.initState();
    barBackgroundColor =
        setColorScheme(numScheme: widget.userColorScheme, numcolor: 6);
    barColor = setColorScheme(numScheme: widget.userColorScheme, numcolor: 1);
    touchedBarColor =
        setColorScheme(numScheme: widget.userColorScheme, numcolor: 2);
  }

  @override
  void dispose() {
    super.dispose();
  }

  String formatHours(int minutes) {
    int hour = minutes ~/ 60;
    var f = NumberFormat('#######');
    return f.format(hour).toString();
  }

  String formatMinutes(int minutes) {
    int min = minutes % 60;
    var f = NumberFormat('#######');
    return f.format(min).toString();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Text(
                  'Weekly Work Time',
                  style: TextStyle(
                    color: setColorScheme(
                        numScheme: widget.userColorScheme, numcolor: 3),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const SizedBox(
                  height: 38,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: BarChart(
                      mainBarData(),
                      swapAnimationDuration: animDuration,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched
              ? touchedBarColor
              : setColorScheme(numScheme: widget.userColorScheme, numcolor: 1),
          width: width,
          borderSide: isTouched
              ? BorderSide(color: touchedBarColor)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: widget.workTimeList.reduce(max).toDouble() * 1.2,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, widget.workTimeList[0].toDouble(),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, widget.workTimeList[1].toDouble(),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, widget.workTimeList[2].toDouble(),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, widget.workTimeList[3].toDouble(),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, widget.workTimeList[4].toDouble(),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, widget.workTimeList[5].toDouble(),
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, widget.workTimeList[6].toDouble(),
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor:
              setColorScheme(numScheme: widget.userColorScheme, numcolor: 0),
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = getNameofDate(6);
                break;
              case 1:
                weekDay = getNameofDate(5);
                break;
              case 2:
                weekDay = getNameofDate(4);
                break;
              case 3:
                weekDay = getNameofDate(3);
                break;
              case 4:
                weekDay = getNameofDate(2);
                break;
              case 5:
                weekDay = getNameofDate(1);
                break;
              case 6:
                weekDay = getNameofDate(0);
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              TextStyle(
                color: setColorScheme(
                    numScheme: widget.userColorScheme, numcolor: 3),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: formatHours((rod.toY - 1).toInt()) == '0'
                      ? '${(formatMinutes((rod.toY - 1).toInt()))}min'
                      : '${(formatHours((rod.toY - 1).toInt()))}hours ${(formatMinutes((rod.toY - 1).toInt()))}min',
                  style: TextStyle(
                    color: setColorScheme(
                        numScheme: widget.userColorScheme, numcolor: 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    var style = TextStyle(
      color: setColorScheme(numScheme: widget.userColorScheme, numcolor: 3),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(getNameofDate(6), style: style);
        break;
      case 1:
        text = Text(getNameofDate(5), style: style);
        break;
      case 2:
        text = Text(getNameofDate(4), style: style);
        break;
      case 3:
        text = Text(getNameofDate(3), style: style);
        break;
      case 4:
        text = Text(getNameofDate(2), style: style);
        break;
      case 5:
        text = Text(getNameofDate(1), style: style);
        break;
      case 6:
        text = Text(getNameofDate(0), style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}
