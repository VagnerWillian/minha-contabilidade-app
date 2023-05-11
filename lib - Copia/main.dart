import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modules/app_modules.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppModules.pages,
    );
  }
}