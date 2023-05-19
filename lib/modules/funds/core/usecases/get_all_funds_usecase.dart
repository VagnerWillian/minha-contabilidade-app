import '../../../../core/core.dart';
import '../domain/repositories/repository.dart';

class GetAllFundsUseCase {
  final FundsRepository _repository;
  GetAllFundsUseCase(this._repository);

  Future<List<FundEntity>> call(bool isAdmin, List<dynamic> cards) async {
    var list = await _repository.getAllFunds();
    if (!isAdmin) {
      return list.where((f) => cards.contains(f.id)).toList();
    }
    return list;
  }
}
