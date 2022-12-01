import 'package:finance_app/app/routes/app_pages.dart';
import 'package:finance_app/app/shared/services_initializer/services_initializer.dart';
import 'package:finance_app/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  await ServicesInitializer.initialize();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.initial,
      theme: appThemeData,
      getPages: AppPages.pages,
    ),
  );
}
