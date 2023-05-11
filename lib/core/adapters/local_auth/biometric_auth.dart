enum AuthBioType {
  face,
  fingerprint,
  iris,
  strong,
  weak,
}

abstract class BiometricAuthAdapter {
  Future<bool> hasBiometrics();
  Future<List<AuthBioType>> getBiometrics();
  Future<bool> authenticate();
}
