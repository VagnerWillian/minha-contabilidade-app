import '../domain/repositories/repository.dart';

class UpdateFundsFromUserUseCase{
  final UsersRepository _repository;
  UpdateFundsFromUserUseCase(this._repository);

  Future<void> call(String uid, List<dynamic> funds)async{
    return await _repository.updateFundsFromUser(uid, funds);
  }
}