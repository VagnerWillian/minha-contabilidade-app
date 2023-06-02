import '../../ui/modals/auth_modal/core/domain/entities/entities.dart';

abstract class AuthenticationAdapter {
  Future<AuthCredentialsEntity> signInWithEmailAndPassword(String email, String pass);
  Future<AuthCredentialsEntity> createAccountWithEmailAndPassword(String email, String pass);
  Future<void> sendEmailVerification();
  Future<void> signOut();
}