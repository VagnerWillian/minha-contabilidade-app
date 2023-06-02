import '../../../../core/core.dart';
import '../../../../core/ui/modals/auth_modal/core/domain/entities/entities.dart';

class CreateAccountWithEmailAndPassUseCase {
  final AuthenticationServiceInterface _authenticationService;

  CreateAccountWithEmailAndPassUseCase(this._authenticationService);

  Future<AuthCredentialsEntity> call(String email, String pass) async {
    return await _authenticationService.createAccountWithEmailAndPassword(email, pass);
  }

}
