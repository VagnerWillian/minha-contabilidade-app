import '../core/core.dart';
import '../core/ui/modals/auth_modal/core/domain/entities/entities.dart';

class AuthenticationService implements AuthenticationServiceInterface{
  final AuthenticationAdapter _adapter;
  AuthenticationService(this._adapter);

  @override
  Future<AuthCredentialsEntity> signInWithEmailAndPassword(String email, String pass){
    return _adapter.signInWithEmailAndPassword(email, pass);
  }

  @override
  Future<AuthCredentialsEntity> signInWithPhoneAndPassword(String phoneNumber){
    return _adapter.signInWithPhoneAndPassword(phoneNumber);
  }

  @override
  Future<void> sendEmailVerification() async {
    return _adapter.sendEmailVerification();
  }

  @override
  Future<void> signOut() async{
    return await _adapter.signOut();
  }
}