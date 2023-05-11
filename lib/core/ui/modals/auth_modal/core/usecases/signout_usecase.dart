import '../../../../../core.dart';
import '../domain/usecases/usecases.dart';

class SignOutUseCase implements SignOutUseCaseInterface {
  final AuthenticationServiceInterface _authService;
  SignOutUseCase(this._authService);

  @override
  Future<void> call() async {
    return await _authService.signOut();
  }
}
