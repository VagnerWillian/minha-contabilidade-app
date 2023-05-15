import '../../../../../../core.dart';

abstract class AuthModalRepository{
  Future<UserEntity> getUserData(String uid);
}