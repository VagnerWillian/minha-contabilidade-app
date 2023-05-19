import 'package:get/get.dart';

import 'core/domain/repositories/repository.dart';
import 'core/infra/repositories/firebase_repository.dart';
import 'core/usecases/usecases.dart';
import 'funds_controller.dart';

class FundsBindings implements Bindings {
  @override
  void dependencies() {
    // Controller
    Get
      ..lazyPut(
        () => FundsController(
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
        ),
      )

      // UseCases
      ..lazyReplace(() => GetAllFundsUseCase(Get.find()))
      ..lazyPut(() => GetAllBrandsUseCase(Get.find()))
      ..lazyPut(() => CreateFundUseCase(Get.find()))
      ..lazyPut(() => DeleteFundUseCase(Get.find()))

      // Repositories
      ..lazyPut<FundsRepository>(() => FirebaseFundsRepository());
  }
}
