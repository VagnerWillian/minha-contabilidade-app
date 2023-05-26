import '../domain/entities/entities.dart';
import '../domain/repositories/repository.dart';

class CreateTransactionUseCase {
  final HomeRepository _repository;
  CreateTransactionUseCase(this._repository);

  Future<void> call(TransactionEntity transaction) async {
    return await _repository.createTransaction(transaction);
  }
}
