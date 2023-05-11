import '../../../../../../core.dart';

abstract class AuthModalRepository{
  Future<UserEntity> getUserData();
}