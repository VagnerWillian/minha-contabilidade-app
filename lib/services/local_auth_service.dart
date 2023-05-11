import '../core/adapters/local_auth/biometric_auth.dart';
import '../core/adapters/local_auth/local_auth.dart';
import '../core/core.dart';

class LocalAuthService implements LocalAuthServiceInterface {
  late final BiometricAuthAdapter _biometricAuthAdapter;

  LocalAuthService() {
    _biometricAuthAdapter = LocalAuth();
  }

  @override
  Future<bool> authenticate() async{
    return await _biometricAuthAdapter.authenticate();
  }

  @override
  Future<List<AuthBioType>> getBiometrics() async{
    return await _biometricAuthAdapter.getBiometrics();
  }

  @override
  Future<bool> hasBiometrics() async{
    return await _biometricAuthAdapter.hasBiometrics();
  }
}
