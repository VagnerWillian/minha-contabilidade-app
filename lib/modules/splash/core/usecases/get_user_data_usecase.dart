import '../../../../core/core.dart';
import '../domain/repositories/repositories.dart';
import '../domain/usecases/usecases.dart';

class GetUserDataUseCase implements GetUserDataUseCaseInterface{
  final SplashRepository _repository;
  GetUserDataUseCase(this._repository);

  @override
  Future<UserEntity> call(String uid)async{
    return await _repository.getUserData(uid);
  }
}