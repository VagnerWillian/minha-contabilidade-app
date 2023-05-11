import '../../../../../core/core.dart';

abstract class SplashRepository{
  Future<UserEntity> getUserData();
}