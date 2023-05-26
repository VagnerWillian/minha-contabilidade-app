import '../domain/repositories/repository.dart';

class CreateFundUseCase {
  final FundsRepository _repository;
  CreateFundUseCase(this._repository);

  Future<void> call(Map<String, dynamic> data) async {
    return await _repository.createFund(data);
  }
}
