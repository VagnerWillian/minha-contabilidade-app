import '../../../../core/core.dart';
import '../domain/repositories/repository.dart';

class GetAllUsersUseCase{
  final UsersRepository _repository;
  GetAllUsersUseCase(this._repository);

  Future<List<UserEntity>> call() async{
    return await _repository.getAllUsers();
  }
}