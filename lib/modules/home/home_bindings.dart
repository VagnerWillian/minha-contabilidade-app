import 'package:get/get.dart';

import 'core/domain/repositories/repository.dart';
import 'core/infra/repositories/firebase_repository.dart';
import 'core/usecases/usecases.dart';
import 'home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    // Controllers
    Get
      ..lazyPut(() => HomeController(
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find(),
          ))

      //UseCases
      ..lazyReplace(() => GetAllFundsUseCase(Get.find()))
      ..lazyReplace(() => GetAllUsersUseCase(Get.find()))
      ..lazyPut(() => GetSummaryFromFund(Get.find()))
      ..lazyPut(() => CreateSummaryFundUseCase(Get.find()))
      ..lazyPut(() => UpdateSummaryFundUseCase(Get.find()))
      ..lazyPut(() => GetAllTransactionsUseCase(Get.find()))
      ..lazyPut(() => CreateTransactionUseCase(Get.find()))
      ..lazyPut(() => CreateTransactionUseCase(Get.find()))
      ..lazyPut(() => DeleteTransactionUseCase(Get.find()))
      ..lazyPut(() => UpdateTransactionUseCase(Get.find()))

      //Repositories
      ..lazyPut<HomeRepository>(() => FirebaseHomeRepository());
  }
}
