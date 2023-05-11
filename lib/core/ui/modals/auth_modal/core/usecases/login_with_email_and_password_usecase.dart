import '../../../../../core.dart';
import '../domain/entities/entities.dart';
import '../domain/usecases/login_with_email_and_password_usecase.dart';

class LoginWithEmailAndPassUseCase implements LoginWithEmailAndPassUseCaseInterface{
  final AuthenticationServiceInterface _authService;
  LoginWithEmailAndPassUseCase(this._authService);

  @override
  Future<AuthCredentialsEntity> call(String email, String pass)async{
    return await _authService.signInWithEmailAndPassword(email, pass);
  }
}