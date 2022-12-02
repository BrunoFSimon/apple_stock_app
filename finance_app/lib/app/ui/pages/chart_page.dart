import 'package:finance_app/app/controllers/chart/chart_controller.dart';
import 'package:finance_app/app/ui/widgets/app_error_widget/app_error_widget.dart';
import 'package:finance_app/app/ui/widgets/charts/finance_chart_widget/finance_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartPagePage extends GetView<ChartController> {
  const ChartPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: controller.obx(
        (state) {
          var result = state;

          if (result == null) throw Exception('state is null');

          return SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
              child: Column(
                children: [
                  const Icon(
                    Icons.apple,
                    color: Colors.grey,
                    size: 50,
                  ),
                  const Text(
                    'AAPL',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 40,
                    ),
                    child: Column(
                      children: [
                        const Text('Preço Atual',
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                        Text(
                          '${result.currentValue} ${result.currencyCode}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Variação dessa ação hoje',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(Icons.arrow_upward),
                      Text(
                        '${result.variation} ${result.currencyCode}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FinanceChartWidget(
                        currencyCode: result.currencyCode,
                        currentValue: result.currentValue,
                        variation: result.variation,
                        items: result.items
                            .map(
                              (e) => FinanceChartItem(
                                value: e.value,
                                day: e.date.day,
                                month: e.date.month,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () {
                      if (controller.isRefreshing.value) {
                        return const RefreshProgressIndicator();
                      }

                      return OutlinedButton(
                        onPressed: controller.reload,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.refresh),
                            SizedBox(width: 8),
                            Text('Atualizar'),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
        onError: (error) {
          return AppErrorWidget(
            message: error ?? 'Erro Desconhecido',
            onRetry: controller.retry,
          );
        },
      ),
    );
  }
}
