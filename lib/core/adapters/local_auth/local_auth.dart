import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

import 'biometric_auth.dart';

class LocalAuth implements BiometricAuthAdapter {
  final _auth = LocalAuthentication();
  final _androidStrings = const AndroidAuthMessages(
    signInTitle: 'Autentificação requerida',
    biometricHint: 'Verificação de identidade',
    biometricRequiredTitle: 'Use sua biometria para autenticação',
    cancelButton: 'Cancelar',
    biometricNotRecognized: 'Não reconhecido',
    goToSettingsButton: 'Configurações',
    goToSettingsDescription: 'Por favor, configure sua biometria',
  );

  final _iosStrings = const IOSAuthMessages(
    cancelButton: 'Cancelar',
    goToSettingsButton: 'Configurações',
    goToSettingsDescription: 'Por favor, configure sua biometria',
  );

  @override
  Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (_) {
      return false;
    }
  }

  @override
  Future<List<AuthBioType>> getBiometrics() async {
    List<AuthBioType> biometrics = [];
    try {
      List<BiometricType> biometricsType = await _auth.getAvailableBiometrics();
      biometricsType.map((e) {
        biometrics.add(AuthBioType.values.byName(e.name));
      }).toList();
      return biometrics;
    } on PlatformException catch (_) {
      return [];
    }
  }

  @override
  Future<bool> authenticate() async {
    var isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
        localizedReason: 'Utilize sua biometria para autenticar',
        authMessages: <AuthMessages>[
          _androidStrings,
          _iosStrings,
        ],
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (_) {
      return false;
    }
  }
}
