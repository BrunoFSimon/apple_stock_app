import 'package:finance_app/app/ui/theme/text_styles.dart';
import 'package:finance_app/app/ui/widgets/apple_logo/apple_logo_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controllers/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppleLogoWidget(),
              const SizedBox(height: 16),
              Text(
                'Aplicativo para visualização em tempo real da ação da Apple (AAPL)',
                style: TextStyles.normal,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: controller.pushChartPage,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Visualização em Gráfico'),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.graphic_eq_outlined)
                  ],
                ),
              ),
              const SizedBox(height: 4),
              OutlinedButton(
                onPressed: controller.pushChartPage,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Visualização em Tabela'),
                    SizedBox(width: 8),
                    const Icon(Icons.table_chart_outlined)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
