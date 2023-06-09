import 'package:get/get.dart';

import '../../../controllers/auth_user_controller.dart';
import '../../../core/core.dart';
import '../../../core/ui/modals/auth_modal/core/infra/models/models.dart';
import '../core/domain/usecases/usecases.dart';

class SplashController extends GetxController with MessagesMixin {
  final AuthUserController _authUserController;
  final ConfigLocalServiceInterface _localStorageService;
  final RemoteConfigServiceInterface _remoteConfigService;
  final NetworkServiceInterface _networkService;
  final GetUserDataUseCaseInterface _getUserDataUseCase;

  SplashController(
    this._authUserController,
    this._localStorageService,
    this._remoteConfigService,
    this._networkService,
    this._getUserDataUseCase,
  );

  final _message = Rxn<MessageModel>();

  Future<void> init() async {
    messageListener(_message);
    await loadRemoteConfigAndInitialize();
  }

  Future<void> loadRemoteConfigAndInitialize() async {
    try {
      // await _remoteConfigService.init();
      hasFirstAccess();
    } on Failure catch (err) {
      _defineError(err);
    }
  }

  Future<void> hasFirstAccess() async {
    bool first = await _localStorageService.getFirstAccess();
    String loggedUUID = await _getSessionData();
    if (loggedUUID.isNotEmpty) {
      bool userOk = await _getUserData(loggedUUID);
      if (userOk) Get.offAllNamed(AppRoutes.mainRoute);
    } else {
      Get.offAllNamed(AppRoutes.startRoute);
    }
  }

  Future<String> _getSessionData() async {
    var uid = await _localStorageService.getUIDData();
    if (uid.isNotEmpty) {
      _authUserController.setLoggedCredentials(
        AuthCredentials(
          uid: uid,
          token: '',
          isVerified: true,
        ),
      );
      return uid;
    }
    return '';
  }

  Future<bool> _getUserData(String uid) async {
    try {
      UserEntity user = await _getUserDataUseCase(uid);
      _authUserController.setLoggedUser(user);
      return true;
    } on Failure catch (err) {
      _defineError(err);
      return false;
    }
  }

  Future<void> _defineError(Failure err) async {
    if (err is FailureRemoteConfig) {
      CustomBottomSheet.show(
          context: Get.context!,
          title: err.error,
          message: err.message,
          type: BottomSheetType.error,
          actionMessage: 'Tentar novamente',
          onAction: () {
            init();
            Get.back();
          });
    }
    if (err is FailureNetwork) {
      _message(MessageModel.network(
        title: err.error,
        message: err.message,
        failureNetwork: err,
      ));
    } else if (err is FailureApp) {
      _message(MessageModel.error(
        title: err.error,
      ));
    }
  }
}
