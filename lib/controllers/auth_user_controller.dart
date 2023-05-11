import 'package:get/get.dart';

import '../core/core.dart';
import '../core/ui/modals/auth_modal/core/domain/entities/auth_credentials.dart';

class AuthUserController extends GetxController {
  final ConfigLocalServiceInterface _configLocalService;
  AuthUserController(this._configLocalService);

  AuthCredentialsEntity? loggedCredentials;
  UserEntity? userLogged;

  bool setLoggedCredentials(AuthCredentialsEntity? authCredentials) {
    loggedCredentials = authCredentials;
    return true;
  }

  void setLoggedUser(UserEntity? user) {
    if (loggedCredentials != null && loggedCredentials!.token.isNotEmpty) {
      userLogged = user;
    } else {
      throw FailureApp(message: AppConstants.unauthenticatedUser);
    }
  }

  void signOut() {
    _configLocalService.saveTokenData('');
    setLoggedUser(null);
    setLoggedCredentials(null);
    Get.toNamed(AppRoutes.startRoute);
  }
}
