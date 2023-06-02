import 'package:get/get.dart';

import 'core/usecases/usecases.dart';
import 'signup_controller.dart';

class SignUpBindings implements Bindings {
  @override
  void dependencies() {
    //Controllers
    Get
      ..lazyPut(() => SignUpController(Get.find(), Get.find()))

      //UseCases
      ..lazyPut(() => CreateAccountWithEmailAndPassUseCase(Get.find()))
      ..lazyPut(() => CreateUserDataUseCase());
  }
}
