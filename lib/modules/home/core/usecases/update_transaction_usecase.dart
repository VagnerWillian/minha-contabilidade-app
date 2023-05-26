import '../domain/entities/entities.dart';
import '../domain/repositories/repository.dart';

class UpdateTransactionUseCase {
  final HomeRepository _repository;
  UpdateTransactionUseCase(this._repository);

  Future<void> call(TransactionEntity transaction) async {
    return await _repository.updateTransaction(transaction);
  }
}
