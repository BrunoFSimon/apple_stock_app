import 'package:finance_app/app/controllers/chart/chart_controller.dart';
import 'package:finance_app/app/shared/extensions/double_extension.dart';
import 'package:finance_app/app/ui/theme/space.dart';
import 'package:finance_app/app/ui/theme/text_styles.dart';
import 'package:finance_app/app/ui/widgets/app_error_widget/app_error_widget.dart';
import 'package:finance_app/app/ui/widgets/apple_logo/apple_logo_widget.dart';
import 'package:finance_app/app/ui/widgets/buttons/app_outlined_icon_button.dart';
import 'package:finance_app/app/ui/widgets/charts/finance_chart_widget/finance_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartPagePage extends GetView<ChartController> {
  const ChartPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: controller.obx(
        (state) {
          var result = state;

          if (result == null) throw Exception('state is null');

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppleLogoWidget(),
                  Space.vertical8,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 40,
                    ),
                    child: Column(
                      children: [
                        Text('Preço Nesse Instante', style: TextStyles.normal),
                        Text(
                          '${result.currentValue} ${result.currencyCode}',
                          style: TextStyles.normalBig,
                        ),
                      ],
                    ),
                  ),
                  Space.vertical8,
                  Text(
                    'Variação',
                    style: TextStyles.normal,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(Icons.arrow_upward),
                      Text(
                        '${result.items.last.getDayBeforeVariation} ${result.currencyCode}',
                        style: TextStyles.normalBig,
                      ),
                    ],
                  ),
                  Text(
                    'Valor em relação a última abertura',
                    style: TextStyles.verySmall,
                  ),
                  Space.vertical16,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FinanceChartWidget(
                      currencyCode: result.currencyCode,
                      currentValue: result.currentValue.toCurrencyString(),
                      variation: result.items.last.dayBeforeFormatedValue,
                      items: result.items
                          .map(
                            (e) => FinanceChartItem(
                              value: e.getFormatedValue,
                              day: e.date.day,
                              month: e.date.month,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Space.vertical16,
                  Obx(
                    () {
                      if (controller.isRefreshing.value) {
                        return const RefreshProgressIndicator();
                      }

                      return AppOutlinedIconButton(
                        onPressed: controller.reload,
                        icon: Icons.refresh,
                        title: 'Atualizar',
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
