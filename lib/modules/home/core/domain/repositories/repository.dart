import '../../../../../core/core.dart';
import '../entities/entities.dart';

abstract class HomeRepository {
  Future<List<FundEntity>> getAllFunds();
  Future<List<SummaryTransactionEntity>> getSummaryFromFund(String fundId, String uid);
  Future<void> createSummaryFromFund(
    String uid,
    String fundId,
    String summaryId,
    Map<String, dynamic> data,
  );
}
