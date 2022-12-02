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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: controller.pushChartPage,
              child: const Text('Visualizar Gráfico'),
            ),
          ],
        ),
      ),
    );
  }
}
