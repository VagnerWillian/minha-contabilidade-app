import '../domain/repositories/repository.dart';

class ActiveUserUseCase{
  final UsersRepository _repository;
  ActiveUserUseCase(this._repository);

  Future<void> call(String uid, bool active)async{
    return await _repository.activeUser(uid, active);
  }
}