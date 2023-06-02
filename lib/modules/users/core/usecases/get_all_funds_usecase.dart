import '../../../../core/core.dart';
import '../domain/repositories/repository.dart';

class GetAllFundsUseCase{
  final UsersRepository _repository;
  GetAllFundsUseCase(this._repository);

  Future<List<FundEntity>> call() async{
    return await _repository.getAllFunds();
  }
}