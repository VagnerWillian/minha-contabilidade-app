import '../domain/entities/entities.dart';
import '../domain/repositories/repository.dart';

class UpdateSummaryFundUseCase {
  final HomeRepository _repository;
  UpdateSummaryFundUseCase(this._repository);

  Future<void> call(
    String uid,
    SummaryTransactionEntity summary,
  ) async {
    return await _repository.updateSummaryFromFund(
      uid,
      summary,
    );
  }
}
