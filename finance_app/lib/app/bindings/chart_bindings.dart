import 'package:finance_app/app/controllers/chart/chart_arguments.dart';
import 'package:finance_app/app/controllers/chart/chart_controller.dart';
import 'package:get/get.dart';

class ChartBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ChartController(
          arguments: ChartArguments(symbol: 'AAPL'), repository: Get.find()),
    );
  }
}
