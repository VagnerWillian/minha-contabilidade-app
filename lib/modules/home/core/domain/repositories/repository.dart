import '../entities/entities.dart';

abstract class HomeRepository{
  Future<List<FundEntity>> getAllFunds();
  Future<List<SummaryTransactionEntity>> getSummaryFromFund(String fundId, String uid);
}