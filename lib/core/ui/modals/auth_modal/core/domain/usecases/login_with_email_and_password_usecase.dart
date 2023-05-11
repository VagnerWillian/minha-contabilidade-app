import '../entities/entities.dart';

abstract class LoginWithEmailAndPassUseCaseInterface{
  Future<AuthCredentialsEntity> call(String email, String pass);
}