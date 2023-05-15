import '../domain/entities/entities.dart';
import '../domain/repositories/repository.dart';

class GetSummaryFromFund{
  final HomeRepository _repository;
  GetSummaryFromFund(this._repository);

  Future<List<SummaryTransactionEntity>> call(String fundId, String uid)async{
    return await _repository.getSummaryFromFund(fundId, uid);
  }
}