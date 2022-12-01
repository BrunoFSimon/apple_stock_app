import 'package:finance_app/app/ui/widgets/app_error_widget/app_error_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controllers/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: controller.obx(
        (state) {
          var result = state?.chart.result;

          if (result == null) throw Exception('result is null');

          return const Center(child: Text('Data successfully loaded'));
        },
        onError: (error) {
          return AppErrorWidget(
            message: error ?? 'Unknown Error',
            onRetry: controller.retry,
          );
        },
      ),
    );
  }
}
