import 'package:finance_app/app/controllers/home/home_arguments.dart';
import 'package:get/get.dart';
import '../controllers/home/home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(
      HomeController(arguments: HomeArguments()),
    );
  }
}
