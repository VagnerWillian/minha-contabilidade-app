import '../../../../../core/core.dart';

abstract class GetUserDataUseCaseInterface{
  Future<UserEntity> call(String uid);
}