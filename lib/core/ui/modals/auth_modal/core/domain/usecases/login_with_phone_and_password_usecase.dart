import '../entities/entities.dart';

abstract class LoginWithPhoneAndPassUseCaseInterface{
  Future<AuthCredentialsEntity> call(String phone, String pass);
}