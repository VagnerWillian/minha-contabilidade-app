import '../../core.dart';
import '../../ui/modals/auth_modal/core/domain/entities/entities.dart';
import '../../ui/modals/auth_modal/core/infra/models/models.dart';
import 'authentication.dart';

class MockAuthentication implements AuthenticationAdapter {
  bool verified = false;

  @override
  Future<AuthCredentialsEntity> signInWithEmailAndPassword(String email, String pass) async {
    await Future.delayed(const Duration(seconds: 2));
    return AuthCredentials(token: 'token', isVerified: verified);
  }

  @override
  Future<AuthCredentialsEntity> signInWithPhoneAndPassword(String phoneNumber) async {
    await Future.delayed(const Duration(seconds: 2));
    return AuthCredentials(token: 'token', isVerified: verified);
  }

  @override
  Future<String?> sendEmailVerification() async {
    await Future.delayed(const Duration(seconds: 2));
    verified = true;
    return null;
  }

  @override
  Future<void> signOut() async {}
}