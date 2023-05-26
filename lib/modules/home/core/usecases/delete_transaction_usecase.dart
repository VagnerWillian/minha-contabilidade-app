import '../domain/entities/entities.dart';
import '../domain/repositories/repository.dart';

class DeleteTransactionUseCase {
  final HomeRepository _repository;
  DeleteTransactionUseCase(this._repository);

  Future<void> call(TransactionEntity transaction) async {
    return await _repository.deleteTransaction(transaction);
  }
}
