import 'package:get/get.dart';

import '../../controllers/controllers.dart';
import '../core.dart';

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
      ..put<RemoteConfigServiceInterface>(RemoteConfigService(Get.find()));
  }
}
