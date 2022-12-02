import 'package:finance_app/app/ui/widgets/app_error_widget/app_error_widget.dart';
import 'package:finance_app/app/ui/widgets/charts/finance_chart_widget/finance_chart_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controllers/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: controller.obx(
        (state) {
          var result = state?.chart.result;

          if (result == null) throw Exception('result is null');

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
            child: FinanceChartWidget(items: [
              FinanceChartItem(value: 1.2, day: 1, month: 11),
              FinanceChartItem(value: 2.3, day: 2, month: 11),
              FinanceChartItem(value: 3.4, day: 3, month: 11),
              FinanceChartItem(value: 1.5, day: 4, month: 11),
              FinanceChartItem(value: 2.6, day: 5, month: 11),
              FinanceChartItem(value: 3.7, day: 6, month: 11),
              FinanceChartItem(value: 7.8, day: 7, month: 11),
              FinanceChartItem(value: 8.9, day: 8, month: 11),
              FinanceChartItem(value: 1.0, day: 9, month: 11),
              FinanceChartItem(value: 3.1, day: 10, month: 11),
              FinanceChartItem(value: 11.2, day: 11, month: 11),
              FinanceChartItem(value: 5.3, day: 12, month: 11),
              FinanceChartItem(value: 6.4, day: 13, month: 11),
              FinanceChartItem(value: 7.5, day: 14, month: 11),
              FinanceChartItem(value: 8.6, day: 15, month: 11),
              FinanceChartItem(value: 9.7, day: 16, month: 11),
              FinanceChartItem(value: 10.8, day: 17, month: 11),
              FinanceChartItem(value: 11.9, day: 18, month: 11),
              FinanceChartItem(value: 12.0, day: 19, month: 11),
              FinanceChartItem(value: 13.1, day: 20, month: 11),
              FinanceChartItem(value: 14.2, day: 21, month: 11),
              FinanceChartItem(value: 15.3, day: 22, month: 11),
              FinanceChartItem(value: 1.4, day: 23, month: 11),
              FinanceChartItem(value: 3.5, day: 24, month: 11),
              FinanceChartItem(value: 9.6, day: 25, month: 11),
              FinanceChartItem(value: 2.7, day: 26, month: 11),
              FinanceChartItem(value: 7.8, day: 27, month: 11),
              FinanceChartItem(value: 7.9, day: 28, month: 11),
              FinanceChartItem(value: 7.0, day: 29, month: 11),
              FinanceChartItem(value: 7.1, day: 30, month: 11),
            ]),
          );
        },
        onError: (error) {
          return AppErrorWidget(
            message: error ?? 'Unknown Error',
            onRetry: controller.retry,
          );
        },
      ),
    );
  }
}
