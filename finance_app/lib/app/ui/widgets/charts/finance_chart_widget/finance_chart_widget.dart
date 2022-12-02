import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:finance_app/app/shared/extensions/double_list_extensions.dart';

class FinanceChartItem {
  final double value;
  final int day;
  final int month;

  FinanceChartItem({
    required this.value,
    required this.day,
    required this.month,
  });
}

class FinanceChartWidget extends StatefulWidget {
  final List<FinanceChartItem> items;

  const FinanceChartWidget({
    super.key,
    required this.items,
  });

  @override
  State<FinanceChartWidget> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<FinanceChartWidget> {
  double get getMaxXAxys {
    return widget.items.length.toDouble() - 1;
  }

  double get getMaxYAxys {
    var doubleValues = widget.items.map((item) => item.value);

    var highestDoubleValue = doubleValues.getHighestDoubleValue();

    return highestDoubleValue;
  }

  List<FinanceChartItem> get getItemsOrderedByDay => widget.items
      .map((item) =>
          FinanceChartItem(value: item.value, day: item.day, month: item.month))
      .toList()
    ..sort((a, b) => a.day.compareTo(b.day));

  List<FinanceChartItem> get getItemsOrderedByValue => widget.items
      .map((item) =>
          FinanceChartItem(value: item.value, day: item.day, month: item.month))
      .toList()
    ..sort((a, b) => a.value.compareTo(b.value));

  List<Color> gradientColors = [
    Colors.transparent.withOpacity(0),
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18,
                left: 12,
                top: 24,
                bottom: 12,
              ),
              child: LineChart(
                swapAnimationCurve: Curves.linear,
                swapAnimationDuration: const Duration(milliseconds: 250),
                buildData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle get getTextStyle {
    return const TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
  }

  Widget buildDays(double value, TitleMeta meta) {
    if (getItemsOrderedByDay.length - 1 > value) {
      var day = getItemsOrderedByDay[value.toInt()].day;
      var month = getItemsOrderedByDay[value.toInt()].month;
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text('$day/$month', style: getTextStyle),
      );
    }

    return const SizedBox.shrink();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var firstMark = (getMaxYAxys * 0.1).toInt();
    var seccondMark = (getMaxYAxys * 0.55).toInt();
    var thirdMark = (getMaxYAxys * 1).toInt();

    String text;

    if (value == firstMark) {
      text = firstMark.toStringAsFixed(0);
    } else if (value == seccondMark) {
      text = seccondMark.toStringAsFixed(0);
    } else if (value == thirdMark) {
      text = thirdMark.toStringAsFixed(0);
    } else {
      return const SizedBox.shrink();
    }

    return Text(text, style: getTextStyle);
  }

  double get test => (getMaxYAxys - getMaxYAxys.toInt());

  LineChartData buildData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 2,
        verticalInterval: 2,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.1),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.1),
            strokeWidth: 1,
          );
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
            reservedSize: 30,
            interval: 7,
            getTitlesWidget: buildDays,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.black.withOpacity(0.4)),
      ),
      minX: 0,
      maxX: getMaxXAxys.ceilToDouble(),
      minY: 0,
      maxY: getMaxYAxys.ceilToDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: getFlSpots,
          color: Colors.red.withOpacity(0.5),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> get getFlSpots => getItemsOrderedByDay
      .map((e) => FlSpot(e.day.toDouble() - 1, e.value))
      .toList();
}
