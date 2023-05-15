import 'package:get/get.dart';

import '../../core/core.dart';
import 'controller/controller.dart';
import 'core/domain/repositories/repositories.dart';
import 'core/domain/usecases/usecases.dart';
import 'core/infra/repositories.dart';
import 'core/usecases/usecases.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => SplashController(
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
          ))

      // UseCases
      ..lazyPut<GetUserDataUseCaseInterface>(() => GetUserDataUseCase(Get.find()))

      //Repositories
      ..lazyPut<SplashRepository>(() {
        if (AppConstants.mockApp) return MockSplashRepository();
        return ApiSplashRepository();
      });
  }
}
