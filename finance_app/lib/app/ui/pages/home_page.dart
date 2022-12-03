import 'package:finance_app/app/ui/theme/space.dart';
import 'package:finance_app/app/ui/theme/text_styles.dart';
import 'package:finance_app/app/ui/widgets/apple_logo/apple_logo_widget.dart';
import 'package:finance_app/app/ui/widgets/buttons/app_outlined_icon_button.dart';
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
              Space.vertical16,
              Text(
                'Aplicativo para visualização em tempo real da ação da Apple (AAPL)',
                style: TextStyles.normal,
                textAlign: TextAlign.center,
              ),
              Space.vertical16,
              AppOutlinedIconButton(
                  icon: Icons.graphic_eq_outlined,
                  onPressed: controller.pushChartPage,
                  title: 'Visualização em Gráfico'),
              const SizedBox(height: 4),
              AppOutlinedIconButton(
                icon: Icons.table_chart_outlined,
                onPressed: controller.pushTablePage,
                title: 'Visualização em Tabela',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
