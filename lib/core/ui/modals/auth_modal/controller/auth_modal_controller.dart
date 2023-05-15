import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../../core/core.dart';
import '../../../../../controllers/controllers.dart';
import '../core/domain/entities/auth_credentials.dart';
import '../core/domain/entities/document_lgpd.dart';
import '../core/domain/usecases/usecases.dart';
import '../core/infra/models/models.dart';
import '../ui/models/models.dart';

class AuthModalController extends GetxController with MessagesMixin {
  final LoginWithEmailAndPassUseCaseInterface _loginWithEmailAndPassUseCase;
  final LoginWithPhoneAndPassUseCaseInterface _loginWithPhoneAndPassUseCase;
  final SendEmailConfirmationUseCaseInterface _sendEmailConfirmationUseCase;
  final SignOutUseCaseInterface _signOutUseCase;
  final GetUserDataUseCaseInterface _getUserDataUseCase;
  final ConfigLocalServiceInterface _configLocalService;
  final LocalAuthServiceInterface _localAuthService;

  AuthModalController(
    this._loginWithEmailAndPassUseCase,
    this._loginWithPhoneAndPassUseCase,
    this._sendEmailConfirmationUseCase,
    this._signOutUseCase,
    this._getUserDataUseCase,
    this._configLocalService,
    this._localAuthService,
  );

  final emailOrPhoneField = ''.obs;
  final password = ''.obs;
  final loading = false.obs;
  final step = AuthStep.login.obs;
  final message = Rxn<MessageModel>();
  final showObscurePass = true.obs;
  final rememberDataFields = false.obs;
  final loginWithBiometric = ''.obs;

  bool get isIos => GetPlatform.isIOS;

  final List<DocumentLGPDEntity> docs = [];
  late final AuthUserController _userAuthController;
  late final TextEditingController emailOrPhoneTextController;
  late final TextEditingController passOrPhoneTextController;

  @override
  void onInit() {
    super.onInit();
    _userAuthController = Get.find();
    emailOrPhoneTextController = TextEditingController();
    passOrPhoneTextController = TextEditingController();
    messageListener(message);
    getRememberLogin();
  }

  Future<void> login({bool withBiometrics = false}) async {
    loading(true);
    var authCredentials = await _getCredentials();
    if (authCredentials.uid.isNotEmpty) {
      _userAuthController.setLoggedCredentials(authCredentials);
      if (authCredentials.isVerified) {
          bool confirmBiometric = await _confirmBiometric(
            rememberDataFields.value,
            withBiometrics,
          );
          if (confirmBiometric) completeLogin(useBiometry: withBiometrics);
      } else {
        step(AuthStep.verify);
      }
    } else if (authCredentials.error.isNotEmpty) {
      message(
        MessageModel(
          title: 'Não foi possível entrar',
          message: authCredentials.error,
          type: MessageType.error,
        ),
      );
      loading(false);
    }
  }

  Future<void> completeLogin({bool useBiometry = false}) async {
    step(AuthStep.login);
    await _saveRememberLogin(useBiometry: useBiometry);
    await _saveSession(_userAuthController.loggedCredentials!.uid);
    await _getUserData(_userAuthController.loggedCredentials!.uid);
  }

  Future<void> _getUserData(String uid) async {
    try {
      UserEntity user = await _getUserDataUseCase(uid);
      _userAuthController.setLoggedUser(user);
      openMain();
    } on Failure catch (err) {
      _defineError(err);
    }
  }

  Future<bool> _confirmBiometric(bool remember, bool useBiometrics) async {
    if (!useBiometrics &&
        !kIsWeb) {
      bool hasBiometrics = await _localAuthService.hasBiometrics();
      if (hasBiometrics) step(AuthStep.biometrics);
      return !hasBiometrics;
    }
    return true;
  }

  Future<AuthCredentialsEntity> loginWithEmailAndPassword() async {
    AuthCredentialsEntity authCredentials = await _loginWithEmailAndPassUseCase(
      emailOrPhoneField.value,
      password.value,
    );
    return authCredentials;
  }

  Future<String?> sendEmailVerification() async {
    try {
      await _sendEmailConfirmationUseCase();
    } on Failure catch (err) {
      _defineError(err);
      return err.message;
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _signOutUseCase();
    } on Failure catch (err) {
      _defineError(err);
    }
  }

  Future<AuthCredentialsEntity> _getCredentials() async {
    late AuthCredentialsEntity credentials;
    if (emailOrPhoneField.value.isAEmail) {
      credentials = await loginWithEmailAndPassword();
    } else if (emailOrPhoneField.value.isAPhoneNumber) {
      credentials = await _loginWithPhoneAndPassword();
    }
    return credentials;
  }


  Future<AuthCredentialsEntity> _loginWithPhoneAndPassword() async {
    await _loginWithPhoneAndPassUseCase(
      emailOrPhoneField.value,
      password.value,
    );
    return AuthCredentials.failure();
  }

  Future<void> _saveSession(String uid) async {
    await _configLocalService.saveUUIDData(uid);
  }

  Future<void> _saveRememberLogin({bool useBiometry = false}) async {
    if (rememberDataFields.isTrue) {
      var data = RememberLogin(
          email: emailOrPhoneField.value,
          pass: password.value,
          biometrySecurity: useBiometry,
          remember: rememberDataFields.value);
      if (useBiometry || rememberDataFields.isTrue) {
        if (!useBiometry) data.clearPass();
        _configLocalService.saveLoginData(data.toSource());
      } else {
        await _configLocalService.saveLoginData('');
      }
    }
  }

  Future<void> getRememberLogin() async {
    var source = await _configLocalService.getLoginData();
    if (source.isNotEmpty) {
      var savedLoginData = RememberLogin.fromSource(source);
      emailOrPhoneField(savedLoginData.email);
      password(savedLoginData.pass);
      if (savedLoginData.biometrySecurity) loginWithBiometric(savedLoginData.email);
      if (savedLoginData.remember) {
        emailOrPhoneTextController.text = savedLoginData.email;
        passOrPhoneTextController.text = savedLoginData.pass;
        if (emailOrPhoneTextController.text.isNotEmpty) rememberDataFields(true);
        if (savedLoginData.pass.isNotEmpty) {
          showObscurePass(false);
        }
      }
    }
  }

  Future<void> authenticateWithBiometrics()async{
    bool validBiometry = await _localAuthService.authenticate();
    if(validBiometry) login(withBiometrics: true);
  }

  Future<void> openMain() async {
    if (step.value != AuthStep.login) {
      loading(true);
      step(AuthStep.login);
      await Future.delayed(const Duration(seconds: 1));
    }
    Get.offAllNamed(AppRoutes.mainRoute);
  }

  void _defineError(Failure err) {
    if (err is FailureNetwork) {
      message(MessageModel.network(
        title: err.error,
        message: err.message,
        failureNetwork: err,
      ));
    } else if (err is FailureApp) {
      message(MessageModel.error(
        title: err.error,
      ));
    }
  }
}
