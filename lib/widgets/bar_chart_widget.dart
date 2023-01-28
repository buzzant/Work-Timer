import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/color_scheme.dart';
import 'package:pomodoro_app/constants/date.dart';

class BarChartWidget extends StatefulWidget {
  final int numScheme;
  const BarChartWidget(
      {Key? key, required this.points, required this.numScheme})
      : super(key: key);

  final List<TimebyDate> points;

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState(points: points);
}

class _BarChartWidgetState extends State<BarChartWidget> {
  final List<TimebyDate> points;

  _BarChartWidgetState({required this.points});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4,
      child: BarChart(
        BarChartData(
          backgroundColor:
              setColorScheme(numScheme: widget.numScheme, numcolor: 0),
          barGroups: _chartGroups(),
          borderData: FlBorderData(border: const Border(bottom: BorderSide())),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _chartGroups() {
    return points
        .map((point) => BarChartGroupData(
            x: point.index.toInt(),
            barRods: [BarChartRodData(toY: point.timeofDate.toDouble())]))
        .toList();
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = getNameofDate((6 - value).toInt());
          return Text(text);
        },
      );
}
