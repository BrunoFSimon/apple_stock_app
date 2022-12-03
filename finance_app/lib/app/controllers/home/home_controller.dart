import 'package:finance_app/app/controllers/chart/chart_arguments.dart';
import 'package:finance_app/app/controllers/home/home_arguments.dart';
import 'package:finance_app/app/routes/app_pages.dart';
import 'package:finance_app/app/shared/navigator/navigator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeArguments arguments;

  HomeController({required this.arguments});

  void pushChartPage() {
    Navigator.pushPageNamed(
      arguments: ChartArguments(symbol: 'AAPL'),
      route: Routes.chart,
    );
  }
}
