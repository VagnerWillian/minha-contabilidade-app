import '../domain/repositories/repository.dart';

class CreateSummaryFundUseCase {
  final HomeRepository _repository;
  CreateSummaryFundUseCase(this._repository);

  Future<void> call(
    String uid,
    String fundId,
    String summaryId,
    Map<String, dynamic> data,
  ) async {
    return await _repository.createSummaryFromFund(
      uid,
      fundId,
      summaryId,
      data,
    );
  }
}
