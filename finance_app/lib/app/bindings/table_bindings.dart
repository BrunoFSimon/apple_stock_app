import 'package:finance_app/app/controllers/table/table_arguments.dart';
import 'package:finance_app/app/controllers/table/table_controller.dart';
import 'package:get/get.dart';

class TableBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => TableController(
        arguments: TableArguments(symbol: 'AAPL'),
        repository: Get.find(),
      ),
    );
  }
}
