import '../../../../../../core.dart';

abstract class GetUserDataUseCaseInterface{
  Future<UserEntity> call();
}