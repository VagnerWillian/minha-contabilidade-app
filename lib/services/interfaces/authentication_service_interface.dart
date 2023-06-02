import '../../core/ui/modals/auth_modal/core/domain/entities/entities.dart';

abstract class AuthenticationServiceInterface{
  Future<AuthCredentialsEntity> signInWithEmailAndPassword(String email, String pass);
  Future<AuthCredentialsEntity> createAccountWithEmailAndPassword(String email, String pass);
  Future<void> sendEmailVerification();
  Future<void> signOut();
}