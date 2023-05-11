import 'package:get/get.dart';

import 'controller/controller.dart';

class StartBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => StartController(),
    );
  }
}
