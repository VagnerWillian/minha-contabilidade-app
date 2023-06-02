import 'package:get/get.dart';

import 'core/domain/repositories/repository.dart';
import 'core/infra/repositories/repositories.dart';
import 'core/usecases/usecases.dart';
import 'users_controller.dart';

class UsersBindings implements Bindings {
  @override
  void dependencies() {
    // Controller
    Get
      ..lazyPut(() => UsersController(
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
          ))

      //Usecases
      ..lazyReplace(() => GetAllUsersUseCase(Get.find()))
      ..lazyReplace(() => GetAllFundsUseCase(Get.find()))
      ..lazyPut(() => ActiveUserUseCase(Get.find()))
      ..lazyPut(() => UpdateFundsFromUserUseCase(Get.find()))

      //Repositories
      ..lazyPut<UsersRepository>(() => FirestoreUsersRepository());
  }
}
