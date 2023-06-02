import 'package:get/get.dart';

import '../../../core.dart';
import 'core/domain/repositories/repositories.dart';
import 'core/domain/usecases/usecases.dart';
import 'core/infra/repositories/repositories.dart';
import 'core/usecases/usecases.dart';

class AuthModalBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    //Repositories
    await Get.putAsync<AuthModalRepository>(
      () async {
        if (AppConstants.mockApp) return MockAuthModalRepository();
        return ApiAuthModalRepository();
      },
    );

    // UseCases
    await Get.putAsync<LoginWithEmailAndPassUseCaseInterface>(
        () async => LoginWithEmailAndPassUseCase(Get.find()));
    await Get.putAsync<SendEmailConfirmationUseCaseInterface>(
        () async => SendEmailConfirmationUseCase(Get.find()));
    await Get.putAsync<SignOutUseCaseInterface>(
      () async => SignOutUseCase(Get.find()),
    );
    await Get.putAsync<GetUserDataUseCaseInterface>(
      () async => GetUserDataUseCase(Get.find()),
    );

    await Get.putAsync<AuthModalController>(
      () async => AuthModalController(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
  }
}
