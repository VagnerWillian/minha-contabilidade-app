import 'package:get/get.dart';

import '../../controllers/controllers.dart';
import '../core.dart';
import '../ui/modals/auth_modal/core/domain/repositories/repositories.dart';
import '../ui/modals/auth_modal/core/infra/repositories/repositories.dart';

class AppBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync<ConfigLocalServiceInterface>(() async => await ConfigLocalService().init());
    Get
      ..put(GetConnect())
      ..put<AuthUserController>(AuthUserController(Get.find()))
      ..put<GlobalController>(GlobalController())
      ..lazyPut<RemoteConfigAdapter>(() {
        if (AppConstants.mockApp) return MockRemoteConfig();
        return FirebaseRemoteConfig();
      })
      ..put<NetworkAdapter>(GetConnectNetwork(Get.find(), Get.find()))
      ..put<NetworkServiceInterface>((NetworkService(Get.find())))
      ..lazyPut<AuthenticationAdapter>(() {
        if (AppConstants.mockApp) return MockAuthentication();
        return FirebaseAuthentication();
      })
      ..putAsync<AuthenticationServiceInterface>(() async => AuthenticationService(Get.find()))
      ..putAsync<LocalAuthServiceInterface>(() async => LocalAuthService())
      ..put<RemoteConfigServiceInterface>(RemoteConfigService(Get.find()))
      ;
  }
}
