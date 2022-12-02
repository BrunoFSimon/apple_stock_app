import 'package:finance_app/app/shared/controller_arguments/controller_arguments.dart';
import 'package:get/get.dart';

class Navigator {
  static Future<T> pushPageNamed<T>({
    required ControllerArguments arguments,
    required String route,
  }) async {
    return await Get.toNamed(
      route,
      arguments: arguments,
    );
  }
}
