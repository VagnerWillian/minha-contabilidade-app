import '../../../../../core.dart';
import '../domain/repositories/repositories.dart';
import '../domain/usecases/usecases.dart';

class GetUserDataUseCase implements GetUserDataUseCaseInterface{
  final AuthModalRepository _repository;
  GetUserDataUseCase(this._repository);

  @override
  Future<UserEntity> call()async{
    return await _repository.getUserData();
  }
}