import '../domain/entities/entities.dart';
import '../domain/repositories/repository.dart';

class GetAllTransactionsUseCase {
  final HomeRepository _repository;
  GetAllTransactionsUseCase(this._repository);

  Future<List<TransactionEntity>> call(
      String uid,
      String summaryId,
      String fundId,
      ) async {
    return await _repository.getAllTransactions(uid, summaryId, fundId);
  }
}
