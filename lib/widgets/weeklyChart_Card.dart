import 'package:covid19/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              showTitles: false
            ),
            bottomTitles: SideTitles(
              showTitles: true,
              getTitles: getWeek
            )
          ),
          barGroups: GetBarGroups(),
        )
      ),
    );
  }
}

List GetBarGroups(){
  List<double> barChartDatas = [6, 10, 8, 7, 10, 15, 9];
  List<BarChartGroupData> barChartGroupData = [];

  barChartDatas.asMap().forEach(
    (key, value) => barChartGroupData.add(
      BarChartGroupData(
        x: key,
        barRods: [
          BarChartRodData(
            y: value,
            color: key == 4? kPrimaryColor : kInactiveChartColor,
            width: 16,
          )
        ]
      )
  ));
  return barChartGroupData;
}

String getWeek(double value){
  switch (value.toInt()) {
    case 0:
      return 'SEG';
      break;
    case 1:
      return 'TER';
      break;
    case 2:
      return 'QUA';
      break;
    case 3:
      return 'QUI';
      break;
    case 4:
      return 'SEX';
      break;
    case 5:
      return 'SAB';
      break;
    case 6:
      return 'DOM';
      break;
    default:
  }
}