import '../../../../../core.dart';
import '../domain/usecases/send_email_confirmation_usecase.dart';

class SendEmailConfirmationUseCase implements SendEmailConfirmationUseCaseInterface {
  final AuthenticationServiceInterface _authService;
  SendEmailConfirmationUseCase(this._authService);

  @override
  Future<void> call() async {
    return await _authService.sendEmailVerification();
  }
}
