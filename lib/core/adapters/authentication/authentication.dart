import '../../ui/modals/auth_modal/core/domain/entities/entities.dart';

abstract class AuthenticationAdapter {
  Future<AuthCredentialsEntity> signInWithEmailAndPassword(String email, String pass);
  Future<AuthCredentialsEntity> signInWithPhoneAndPassword(String phoneNumber);
  Future<void> sendEmailVerification();
  Future<void> signOut();
}