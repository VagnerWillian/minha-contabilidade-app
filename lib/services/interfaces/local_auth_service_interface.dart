import '../../core/adapters/local_auth/biometric_auth.dart';

abstract class LocalAuthServiceInterface{
  Future<bool> hasBiometrics();
  Future<List<AuthBioType>> getBiometrics();
  Future<bool> authenticate();
}