import '../../../../../core.dart';
import '../domain/entities/entities.dart';
import '../domain/usecases/login_with_phone_and_password_usecase.dart';

class LoginWithPhoneAndPassUseCase implements LoginWithPhoneAndPassUseCaseInterface {
  final AuthenticationServiceInterface _authService;
  LoginWithPhoneAndPassUseCase(this._authService);

  @override
  Future<AuthCredentialsEntity> call(String phone, String pass) async {
    return await _authService.signInWithPhoneAndPassword(phone);
  }
}
