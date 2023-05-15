import '../../../../controllers/auth_user_controller.dart';
import '../domain/entities/entities.dart';
import '../domain/repositories/repository.dart';

class GetAllFundsUseCase {
  final HomeRepository _repository;
  GetAllFundsUseCase(
    this._repository,
  );

  Future<List<FundEntity>> call(bool isAdmin, List<dynamic> cards) async {
    var list = await _repository.getAllFunds();
    if (!isAdmin) {
      return list.where((f) => cards.contains(f.id)).toList();
    }
    return list;
  }
}
