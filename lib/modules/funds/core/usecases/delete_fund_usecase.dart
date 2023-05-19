import '../../../../core/core.dart';
import '../domain/repositories/repository.dart';

class DeleteFundUseCase {
  final FundsRepository _repository;
  DeleteFundUseCase(this._repository);

  Future<void> call(String id) async {
    return await _repository.deleteFund(id);
  }
}
