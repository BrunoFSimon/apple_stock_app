import 'package:finance_app/app/bindings/chart_bindings.dart';
import 'package:finance_app/app/bindings/home_bindings.dart';
import 'package:finance_app/app/ui/pages/chart_page.dart';
import 'package:finance_app/app/ui/pages/home_page.dart';
import 'package:get/get_navigation/get_navigation.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => const HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: Routes.chart,
      page: () => const ChartPagePage(),
      binding: ChartBindings(),
    ),
  ];
}
