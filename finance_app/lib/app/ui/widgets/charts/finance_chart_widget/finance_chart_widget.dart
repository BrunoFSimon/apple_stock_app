import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:finance_app/app/shared/extensions/double_list_extensions.dart';

class FinanceChartItem {
  final String value;
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
  final String currencyCode;
  final String currentValue;
  final String variation;

  const FinanceChartWidget({
    super.key,
    required this.items,
    required this.currencyCode,
    required this.currentValue,
    required this.variation,
  });

  @override
  State<FinanceChartWidget> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<FinanceChartWidget> {
  double get getMaxXAxys {
    return widget.items.length.toDouble();
  }

  double get getMinYAxys {
    var doubleValues = widget.items.map((item) => item.value);

    var lowestValue = doubleValues.getLowestValue();

    return lowestValue;
  }

  double get getMaxYAxys {
    var doubleValues = widget.items.map((item) => item.value);

    var highestDoubleValue = doubleValues.getHighestDoubleValue();

    return highestDoubleValue;
  }

  List<FinanceChartItem> get getItemsOrderedByValue => widget.items
      .map((item) =>
          FinanceChartItem(value: item.value, day: item.day, month: item.month))
      .toList()
    ..sort((a, b) => a.value.compareTo(b.value));

  List<Color> get gradientColors => [Colors.black.withOpacity(0), Colors.white];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.5,
          child: LineChart(
            swapAnimationCurve: Curves.linear,
            swapAnimationDuration: const Duration(milliseconds: 250),
            buildData(),
          ),
        ),
      ],
    );
  }

  TextStyle get getTextStyle {
    return const TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    );
  }

  Widget buildDays(double value, TitleMeta meta) {
    var day = widget.items[value.toInt()].day;
    var month = widget.items[value.toInt()].month;

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('$day/$month', style: getTextStyle),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String? text;

    if (value == meta.max) {
      text = meta.max.toStringAsFixed(0);
    } else if (value == meta.min) {
      text = meta.min.toStringAsFixed(0);
    }

    var midValue = ((meta.max + meta.min) / 2).ceil();
    if (value == midValue) text = midValue.toStringAsFixed(0);

    if (text != null) return Text(text, style: getTextStyle);

    return const SizedBox.shrink();
  }

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
          axisNameSize: 30,
          axisNameWidget: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Pressione o gráfico para visualização detalhada',
              textAlign: TextAlign.center,
              style: getTextStyle.copyWith(fontWeight: FontWeight.normal),
            ),
          ),
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 8,
            getTitlesWidget: buildDays,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 35,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: Colors.black.withOpacity(0.1)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: getFlSpots,
          isCurved: true,
          color: Colors.white.withOpacity(1),
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

  List<FlSpot> get getFlSpots {
    var list = widget.items
        .map((e) =>
            FlSpot(widget.items.indexOf(e).toDouble(), double.parse(e.value)))
        .toList();

    return list;
  }
}
