import '../../../../../core/core.dart';
import '../entities/entities.dart';

abstract class HomeRepository {
  Future<List<FundEntity>> getAllFunds();
  Future<List<SummaryTransactionEntity>> getSummaryFromFund(String fundId, String uid);
  Future<void> createSummaryFromFund(
    String uid,
    String fundId,
    Map<String, dynamic> data,
  );
  Future<void> updateSummaryFromFund(
    String uid,
    SummaryTransactionEntity transaction,
  );
  Future<List<TransactionEntity>> getAllTransactions(String uid, String summaryId, String fundId);
  Future<void> createTransaction(TransactionEntity transaction);
  Future<void> updateTransaction(TransactionEntity transaction);
  Future<void> deleteTransaction(TransactionEntity transaction);
}
